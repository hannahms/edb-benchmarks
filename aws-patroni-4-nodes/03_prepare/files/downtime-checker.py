#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import psycopg2
import time
from datetime import datetime as dt


def connect(conn_string):
    while True:
        try:
            print("%s INFO: Connecting to PostgreSQL..." % dt.now())
            conn = psycopg2.connect(conn_string)
            print("%s INFO: Connected." % dt.now())
            return conn
        except psycopg2.Error as e:
            print("%s ERROR: Cannot connect, new try." % dt.now())


def monitor_downtime(conn, pg):
    primary_init = None
    primary_current = None
    downtime = None

    # Create the ping table if it doesn't exist.

    try:
        cur = conn.cursor()
        cur.execute("""
            CREATE TABLE IF NOT EXISTS ping (
              node TEXT,
              timestamp TIMESTAMPTZ DEFAULT NOW(),
              cur_lsn pg_lsn
            );
        """)
        conn.commit()
    except psycopg2.DatabaseError as e:
        print(e)
        print("%s ERROR: Cannot bootstrap ping table!" % dt.now())
        return

    while True:
        try:
            cur = conn.cursor()

            # Not leader found yet? then this is the first iteration and we
            # must remove any data from the ping table.
            if primary_init is None:
                cur.execute("TRUNCATE ping")

            # Get current Primary

            if primary_init is None or primary_current is None:
                cur.execute("SELECT inet_server_addr()::TEXT")
                r = cur.fetchone()
                if primary_init is None:
                    primary_init = r[0]
                if primary_current is None:
                    primary_current = r[0]

            # Insert a new record into the ping table

            cur.execute(
                "INSERT INTO ping (node, cur_lsn) VALUES ("
                "  inet_server_addr(), pg_current_wal_lsn())"
            )
            conn.commit()

            # If the current Patroni leader node is different from the initial one,
            # then this must indicate a new Patroni leader node has been promoted.

            if primary_current != primary_init:
                cur2 = conn.cursor()
                cur2.execute(
                    "SELECT MIN(timestamp) - ("
                    "  SELECT MAX(timestamp) FROM ping where node = %s"
                    ") FROM ping WHERE node = %s",
                    (primary_init, primary_current)
                )
                r2 = cur2.fetchone()
                downtime = r2[0]
                conn.commit()
                return downtime

        except psycopg2.OperationalError as e:

            # Connection to the database has been lost, this must be due to a
            # leader change, then we reset primary_current to None.

            primary_current = None
            print("%s ERROR: Connection lost" % dt.now())
            conn = connect(pg)

        except psycopg2.DatabaseError as e:
            primary_current = None
            print(e)
            print("%s ERROR: Cannot insert message" % dt.now())
            conn = connect(pg)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--pg',
        dest='pg',
        type=str,
        help="Postgres connection string to the proxy node.",
        default='',
    )
    env = parser.parse_args()

    conn = connect(env.pg)
    downtime = monitor_downtime(conn, env.pg)
    print("Downtime: %s" % downtime)
    conn.close()


if __name__ == '__main__':
    main()
