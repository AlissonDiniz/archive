<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="menu.new.entity" /></title>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.new.entity" /></h3>
        </div>
        <ul class="nav nav-pills">
            <li role="presentation">
                <a href="<g:createLink action="index" />">
                    <i class="fa fa-fw fa-tasks"></i>
                    <g:message code="command.index.entity" />
                </a>
            </li>
        </ul>
        <g:if test="\${flash.message}">
            <div class="alert alert-success" role="alert">\${flash.message}</div>
        </g:if>
        <g:hasErrors bean="\${${propertyName}}">
            <div class="alert alert-danger" role="alert">
            <g:eachError bean="\${${propertyName}}" var="error">
                <g:message error="\${error}"/>
                <br />
            </g:eachError>
            </div>
        </g:hasErrors>
        <g:form name="form" url="[resource:${propertyName}, action:'save']" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
            <fieldset class="form">
                <g:render template="form"/>
                <div class="col-xs-12 form-group buttons">
                    <button type="button" data-form="form" class="btn btn-default submit">
                        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> <g:message code="default.button.create.label" />
                    </button>
                    <button type="button" data-path="<g:createLink action="index" />" class="btn btn-warning redirect">
                        <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> <g:message code="default.button.cancel.label" />
                    </button>
                </div>
            </fieldset>
        </g:form>
    </body>
</html>
