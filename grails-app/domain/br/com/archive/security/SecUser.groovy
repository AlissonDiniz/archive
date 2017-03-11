package br.com.archive.security

class SecUser {

    transient springSecurityService

    String name
    String username
    String password
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    String owner;
    Date dateCreated;
    Date lastUpdated;

    static transients = ['springSecurityService']

    static constraints = {
        name blank: false
        username blank: false, unique: true
        password blank: false
        owner blank: false
    }

    static mapping = {
        password column: '`password`';
    }

    Set<SecRole> getAuthorities() {
        SecUserSecRole.findAllBySecUser(this).collect { it.secRole } as Set
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }
    
    public String toString() {
        return this.username;
    }
}

