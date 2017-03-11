<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<nav id="top-navigation" class="top-navigation navbar" role="navigation">
    <div class="navbar-header">
        <a class="navbar-brand" href="${resource(dir: '')}">
            <g:img class="maac" dir="images" file="maac-logo.jpg" />
        </a>
    </div>
    <!-- Top Menu Items -->
    <ul class="nav navbar-right">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>${sec.loggedInUserInfo(field:'username')} <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li class="divider"></li>
                <li>
                    <a href="#" onclick="application.changePassword()"><i class="fa fa-fw fa-gear"></i> <g:message code="default.update.password.label" /></a>
                </li>
                <li class="divider"></li>
                <li>
                    <a href="#" onclick="application.logout()"><i class="fa fa-fw fa-power-off"></i> <g:message code="default.logout.label" /></a>
                </li>
            </ul>
        </li>
    </ul>
    <g:form name="logoutForm" action="index" controller="logout"></g:form>
</nav>