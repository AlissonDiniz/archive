<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="menu.show.entity" /></title>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.show.entity" /></h3>
        </div>
        <ul class="nav nav-pills">
            <li role="presentation">
                <a href="<g:createLink action="index" />">
                    <i class="fa fa-fw fa-tasks"></i>
                    <g:message code="command.index.entity" />
                </a>
            </li>
            <li role="presentation">
                <a href="<g:createLink action="create" />">
                    <i class="fa fa-fw fa-plus-circle"></i>
                    <g:message code="command.new.entity" />
                </a>
            </li>
        </ul>
        <g:if test="\${flash.message}">
            <div class="alert alert-success" role="alert">\${flash.message}</div>
        </g:if>
        <div id="show-${domainClass.propertyName}" class="content scaffold-show" role="main">
            <ol class="property-list ${domainClass.propertyName}">
<%  
            excludedProps = Event.allEvents.toList() << 'id' << 'version'
            allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
            props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
            props.each { p -> 
%>
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="${domainClass.propertyName}.${p.name}.label" /></p>
<%  
                if (p.isEnum()) { %>
                    <p class="text-primary"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></p>
<%
                } else if (p.oneToMany || p.manyToMany) { 
%>
                    <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                        <p class="text-primary"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></p>
                    </g:each>
<%  
                } else if (p.manyToOne || p.oneToOne) { 
%>
                    <p class="text-primary"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></p>
<%  
                } else if (p.type == Boolean || p.type == boolean) { 
%>
                    <p class="text-primary"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></p>
<%  
                } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { 
%>
                    <p class="text-primary"><g:formatDate date="\${${propertyName}?.${p.name}}" format="\${message (code: "default.datetime.format")}" /></p>
<%  
                } else if (!p.type.isArray()) { 
%>
                    <p class="text-primary"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></p>
<%  
                } 
%>
                </li>
<%  
                } 
%>
            </ol>
            <div class="col-xs-12 form-group buttons">
                <button type="button" data-path="<g:createLink action="edit" resource="\${${propertyName}}" />" class="btn btn-default redirect">
                    <span class="glyphicon glyphicon-edit" aria-hidden="true"></span> <g:message code="default.button.edit.label" />
                </button>
            </div>
        </div>
    </body>
</html>
