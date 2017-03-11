package br.com.archive.security

class SecRole {

    String authority
    String description;

    static mapping = {
        cache true
    }

    static constraints = {
        authority blank: false, unique: true;
        description blank: false;
    }
        
    public String toString() {
        return this.description;
    }
    
    public boolean equals(final Object objectInstance) {
        boolean equals = false;
        if(objectInstance != null){
            equals = (this.id == objectInstance.id);
        }
        return equals;
    }
}

