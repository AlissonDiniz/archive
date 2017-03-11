modules = {
    moment{
        resource url:'assets/plugins/moment/moment.js'
    }
    maskinput{
        resource url:'assets/plugins/maskinput/jquery.maskedinput.min.js'
    }
    'jquery-ui'{
        resource url:'assets/plugins/jquery-ui/jquery-ui.min.js'
        resource url:'assets/plugins/jquery-ui/jquery-ui.min.css'
    }
    'application-style' {
        dependsOn 'bootstrap, font-awesome, jquery-ui'
        resource url:'css/customs/bootstrap.custom.css'
        resource url:'css/customs/jquery-ui.custom.css'
        resource url:'css/main.css'
    }
    application {
        dependsOn 'application-style, jquery, bootstrap-js, moment, maskinput'
        resource url:'js/application.js'
        resource url:'js/date-util.js'
        resource url:'js/validator.js'
    }
    error{
        resource url:'css/error.css'
    }
    auth{
        resource url:'css/auth.css'
    }
    home{
        resource url:'css/home.css'
    }
    show{
        resource url:'css/show.css'
    }
    list{
        resource url:'css/list.css'
    }
    report{
        resource url:'css/report.css'
    }
    search{
        dependsOn 'application'
        resource url:'css/search.css'
    }
    resultReport{
        resource url:'css/resultReport.css', attrs:[media:'screen, projection, print']
    }
    secUser{
       dependsOn 'application, list, show'
       resource url:'js/domain/sec-user.class.js'
    }
    storageType{
       dependsOn 'application, list, show'
       resource url:'css/domain/storage-type.class.css'
       resource url:'js/domain/storage-type.class.js'
    }
    fileType{
       dependsOn 'application, list, show'
       resource url:'css/domain/file-type.class.css'
       resource url:'js/domain/file-type.class.js'
    }
    treeNode{
       resource url:'assets/component/tree-node/tree-node.class.css'
       resource url:'assets/component/tree-node/tree-node.class.js'
    }
    tagsInput{
       dependsOn 'jquery-ui'
       resource url:'assets/component/tagsinput/jquery.tagit.css'
       resource url:'assets/component/tagsinput/tag-it.min.js'
    }
    classification{
       dependsOn 'application, list, treeNode'
       resource url:'css/domain/classification.class.css'
       resource url:'js/domain/classification.service.js'
       resource url:'js/domain/classification.class.js'
    }
    classificationShow{
       dependsOn 'application, show'
    }
    storage{
       dependsOn 'application, list, treeNode'
       resource url:'css/domain/storage.class.css'
       resource url:'js/domain/storage.service.js'
       resource url:'js/domain/storage.class.js'
    }
    storageShow{
       dependsOn 'application, show'
    }
    file{
       dependsOn 'application, list, treeNode, tagsInput, maskinput'
       resource url:'css/domain/file.class.css'
       resource url:'js/domain/file.class.js'
       resource url:'js/domain/file.service.js'
    }
    fileShow{
       dependsOn 'application, show'
    }
    fileReport{
       dependsOn 'application, tagsInput'
       resource url:'js/domain/file-report.class.js'
    }
}