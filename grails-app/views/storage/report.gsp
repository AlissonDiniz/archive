<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'storage.label', default: 'Storage')}" />
        <title><g:message code="menu.report.storage" args="[entityName]" /></title>
        <r:require module="report"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.report.storage" /></h3>
        </div>
        <g:form name="form" action="resultReport" role="form" target="_blank">
            <fieldset class="form form-report">
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
                <div class="col-xs-8 form-group">
                    <label for="typeReport">
                        <g:message code="storage.report-type.label" />
                    </label>
                    <g:select name="typeReport" class="form-control" from="${br.com.archive.domain.StorageReportType?.values()}" keys="${br.com.archive.domain.StorageReportType.values()}" />
                </div>
                <div class="col-xs-8 checkbox">
                    <label for="detail">
                        <g:checkBox name="detail" />
                        <g:message code="storage.report-detail.label" />
                    </label>
                </div>
                <div class="col-xs-12 form-group buttons">
                    <button type="submit" data-form="form" class="btn btn-default">
                        <span class="glyphicon glyphicon-file" aria-hidden="true"></span> <g:message code="default.button.generate-report.label" />
                    </button>
                </div>
            </fieldset>
        </g:form>
    </body>
</html>
