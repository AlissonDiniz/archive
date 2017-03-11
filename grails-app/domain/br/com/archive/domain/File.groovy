package br.com.archive.domain

class File {

    String code;
    String name;
    static belongsTo = [parentClassification: Classification, parentStorage: Storage];
    String subject;
    FileType type;
    String tagList;
    Date periodInit;
    Date periodEnd;
    String note;
    String owner;
    Date dateCreated;
    Date lastUpdated;
    
    static constraints = {
        code blank: false, unique: true
        name blank: false
        subject nullable: true
        type blank: false
        tagList nullable: true
        periodInit nullable: true
        periodEnd nullable: true
        note nullable: true
        owner blank: false
    }
    static mapping = {
        note type: "text"
    }
}
