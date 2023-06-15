Aidbox_config:
  target: dev
  outputs:
    dev:
      type: postgres
      host: "<db_host>" 
      port: "<db_port>"
      user: "<db_user>"
      password: "<db_password>" 
      dbname: "<db_name>"
      schema: public
      threads: 5
      keepalives_idle: 3 # default 0, indicating the system default. See below
      connect_timeout: 100 # default 10 seconds
      retries: 5  # default 1 retry on error/timeout when opening connections
