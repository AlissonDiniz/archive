package br.com.archive.domain

class Storage {

    String code;
    String name;
    static belongsTo = [parentStorage: Storage];
    static hasMany = [childrenStorage: Storage, fileList: File];
    StorageType type;
    String owner;
    Date dateCreated;
    Date lastUpdated;
    
    static constraints = {
        code blank: false, unique: true
        name blank: false
        type blank: false
        owner blank: false
    }
    
    public String toString(){
        return this.code + " - " + this.name;
    }
}
