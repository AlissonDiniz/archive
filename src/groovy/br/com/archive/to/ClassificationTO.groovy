/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package br.com.archive.to

import br.com.archive.domain.Classification;
import br.com.archive.helper.TreeNode;

/**
 *
 * @author Alisson Diniz
 */
class ClassificationTO extends TreeNode{
    
    List fileTOList
    Date dateCreated;
    
    public ClassificationTO(Classification classificationInstance){
        this.id = classificationInstance.id;
        this.code = classificationInstance.code;
        this.name = classificationInstance.name;
        this.owner = classificationInstance.owner;
        this.dateCreated = classificationInstance.dateCreated;
        this.canDelete = classificationInstance.childrenClassification != null ? !(classificationInstance.childrenClassification.size() > 0) : true;
        this.parentId = classificationInstance.parentClassification != null ? classificationInstance.parentClassification.id : null;
    }
    
    public ClassificationTO(Classification classificationInstance, List fileTOList){
        this.id = classificationInstance.id;
        this.code = classificationInstance.code;
        this.name = classificationInstance.name;
        this.owner = classificationInstance.owner;
        this.fileTOList = fileTOList;
        this.dateCreated = classificationInstance.dateCreated;
        this.canDelete = classificationInstance.childrenClassification != null ? !(classificationInstance.childrenClassification.size() > 0) : true;
        this.parentId = classificationInstance.parentClassification != null ? classificationInstance.parentClassification.id : null;
    }
    
}

