/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package br.com.archive.to

import br.com.archive.domain.Storage;
import br.com.archive.helper.TreeNode;

/**
 *
 * @author Alisson Diniz
 */
class StorageTO extends TreeNode{
    
    Long typeId;
    String type;
    List fileTOList
    Date dateCreated;
    
    public StorageTO(Storage storageInstance){
        this.id = storageInstance.id;
        this.code = storageInstance.code;
        this.name = storageInstance.name;
        this.owner = storageInstance.owner;
        this.typeId = storageInstance.type.id;
        this.type = storageInstance.type.toString();
        this.dateCreated = storageInstance.dateCreated;
        this.canDelete = storageInstance.childrenStorage != null ? !(storageInstance.childrenStorage.size() > 0) : true;
        this.parentId = storageInstance.parentStorage != null ? storageInstance.parentStorage.id : null;
    }
    
    public StorageTO(Storage storageInstance, List fileTOList){
        this.id = storageInstance.id;
        this.code = storageInstance.code;
        this.name = storageInstance.name;
        this.type = storageInstance.type.toString();
        this.fileTOList = fileTOList;
        this.dateCreated = storageInstance.dateCreated;
        this.canDelete = storageInstance.childrenStorage != null ? !(storageInstance.childrenStorage.size() > 0) : true;
        this.parentId = storageInstance.parentStorage != null ? storageInstance.parentStorage.id : null;
    }
	
}

