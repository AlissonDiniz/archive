<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="menu.index.entity" /></title>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.index.entity" /></h3>
        </div>
        <ul class="nav nav-pills">
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
        <g:render template="/components/quick-search" />
        <table class="table table-hover ${domainClass.propertyName}-table">
            <thead>
                <tr>
<%  
                excludedProps = Event.allEvents.toList() << 'id' << 'version'
                allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
                Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                props.eachWithIndex { p, i ->
                    if (i < 6) {
                        if (p.isAssociation()) { 
%>
                            <th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
<%  
                        } else { 
%>
                            <g:sortableColumn property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" />
<%
                        }  
                    }   
                } 
%>
                </tr>
            </thead>
            <tbody>
            <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                <tr class="link \${(i % 2) == 0 ? 'even' : 'odd'}">
<%
                props.eachWithIndex { p, i ->
                    if (i == 0) { 
%>
                    <td><g:link action="show" id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</g:link></td>
<%
                    } else if (i < 6) {
                        if (p.type == Boolean || p.type == boolean) { 
%>
                    <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></td>
<%
                        } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { 
%>
                    <td><g:formatDate date="\${${propertyName}.${p.name}}" format="\${message (code: "default.datetime.format")}" /></td>
<%          
                        } else { 
%>
                    <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
<%  
                        }   
                    }   
                } 
%>
                </tr>
            </g:each>
            </tbody>
        </table>
        <div class="pagination">
            <g:paginate total="\${${propertyName}Count ?: 0}" />
        </div>
    </body>
</html>
