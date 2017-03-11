dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
    logSql = false

    properties {
        maxActive = -1
        minEvictableIdleTimeMillis = 1800000
        timeBetweenEvictionRunsMillis = 1800000
        numTestsPerEvictionRun = 3
        testOnBorrow = true
        testWhileIdle = true
        connectionProperties = "[autoReconnectForPools=true]"
        testOnReturn = true
        validationQuery = "SELECT 1"
    }
}

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://127.0.0.1/archive?useUnicode=yes&characterEncoding=UTF-8"
            username = "root"
            password = "12345"
        }
        hibernate {
            show_sql = true
        }
    }
    test {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://127.0.0.1/archive?useUnicode=yes&characterEncoding=UTF-8"
            username = "root"
            password = "12345"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://127.0.0.1/archive?useUnicode=yes&characterEncoding=UTF-8"
            username = "root"
            password = "f123urne"
        }
    }
}