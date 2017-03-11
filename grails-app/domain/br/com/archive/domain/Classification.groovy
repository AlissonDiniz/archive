package br.com.archive.domain

class Classification {

    String code
    String name
    static belongsTo = [parentClassification: Classification];
    static hasMany = [childrenClassification: Classification, fileList: File]
    String owner;
    Date dateCreated;
    Date lastUpdated;
    
    static constraints = {
        code blank: false, unique: true
        name blank: false
        owner blank: false
    }
    
    public String toString(){
        return this.code + " - " + this.name;
    }
}
