/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package br.com.archive.helper

import br.com.archive.to.FileTO;

/**
 *
 * @author Alisson Diniz
 */
class TreeReportHelper {
    
    public static def createTree(def treeNodeList){
        def tree = [];
        getRootNodes(treeNodeList).sort{it.id}.each{root->
            tree.add(root);
            if(root.fileTOList != null){
                tree.addAll(root.fileTOList);
            } 
            tree.addAll(getChildrenNodes(root, treeNodeList));
        }
        return tree;
    }
    
    public static def getRootNodes(def treeNodeList){
        def roots = [];
        treeNodeList.each{node->
            if(node.parentId == null){
                roots.add(node);
            }
        }
        return roots;
    }
    
    public static def getChildrenNodes(TreeNode root, def treeNodeList){
        def children = [];
        treeNodeList.each{node->
            if(root.id.equals(node.parentId)){
                children.add(node);
                if(node.fileTOList != null){
                    children.addAll(node.fileTOList);
                }
                children.addAll(getChildrenNodes(node, treeNodeList));
            }
        }
        children.sort{it.code};
        return children;
    }
	
}

