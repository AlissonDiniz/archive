/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package br.com.archive.domain

/**
 *
 * @author Alisson Diniz
 */
class FileType {
    
    String name;
    String description;
    String owner;
    Date dateCreated;
    Date lastUpdated;
    
    static constraints = {
        name blank: false, unique: true
        description nullable: true
        owner blank: false
    }
    
    public String toString(){
        return this.name;
    }
}

