<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'storage.label', default: 'Storage')}" />
        <title><g:message code="menu.search.storage" args="[entityName]" /></title>
        <r:require module="search"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.search.storage" /></h3>
        </div>
        <g:form name="form" action="resultSearch" role="form">
            <fieldset class="form form-search">
                <div class="col-xs-8 form-group">
                    <label for="code">
                        <g:message code="storage.code.label" />
                    </label>
                    <g:textField name="code" class="form-control" placeholder="${message (code: "storage.code.label")}" />
                </div>
                <div class="col-xs-8 form-group">
                    <label for="name">
                        <g:message code="storage.name.label" />
                    </label>
                    <g:textField name="name" class="form-control" placeholder="${message (code: "storage.name.label")}" />
                </div>
                <div class="col-xs-8 form-group">
                    <label for="type">
                        <g:message code="storage.type.label" />
                    </label>
                    <g:select name="type" class="form-control" from="${br.com.archive.domain.StorageType.list()}" optionKey="id" optionValue="name" noSelection="${['': g.message(code: "default.field.all")]}" />
                </div>
                <div class="col-xs-12 form-group buttons">
                    <button type="submit" data-form="form" class="btn btn-default">
                        <span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span> <g:message code="default.button.search.label" />
                    </button>
                </div>
            </fieldset>
        </g:form>
    </body>
</html>
