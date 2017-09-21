# Handlebars Templating

Handlebars syntax is a superset of [Mustache templates](https://mustache.github.io/). We are using [handlebars.java](https://github.com/jknack/handlebars.java/) in two different ways:

### 1. Spring MVC

Setup in `mvc-dispatcher-servlet.xml` as

```xml
<bean id="viewResolver" class="com.github.jknack.handlebars.springmvc.HandlebarsViewResolver">
  <property name="order" value="1" />
  <property name="prefix" value="/templates/" />
  <property name="suffix" value=".template.html" />
  <property name="failOnMissingFile" value="false" />
</bean>
```

And having a higher `order` than the `InternalResourceViewResolver`, any existing view path that matches `/templates/${view}.template.html` will be rendered using the handlebars template, otherwise is will be rendered by the matching JSP page `WEB-INF/pages/${view}.jsp`

### 2. JSP Tag

It is possible to include handlebars templates into JSP pages, this allows fast conversion of all `includes/*` subtemplates to handlebars and use them with the JSP ones while those will get converted too.

For exmaple, this include in JSP:

```xml
<c:set var="title" value="Update Profile (Service Admin)"/>
<%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
```

Could be replaces with handlebars include as such:

```xml
<c:set var="title" value="Update Profile (Service Admin)"/>
<h:handlebars template="admin/includes/html_head" context="${pageContext}" />
```

provided that the JSP page declares the taglib as:

```xml
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
```

## Syntax

Mustache is ["logic-less"](https://mustache.github.io/mustache.5.html):

> We call it "logic-less" because there are no if statements, else clauses, or for loops. Instead, there are only tags. Some tags are replaced with a value, some nothing, and others a series of values. This document explains the different types of Mustache tags.

We're using here *handlebars* which is a superset of mustache and it has a set of helpers that provide us with [*if, with, unless, each*](http://handlebarsjs.com/block_helpers.html).

Check [handlebars.js](http://handlebarsjs.com/) and [handlebars.java](https://github.com/jknack/handlebars.java/#helpers) helpers.

Additional helpers can be implemented, however, this should not be necessary as it breaks the compatibility between handlebars implementations.

## Particulars in converting from JSP

### 1. Page Context Data
Data that is not part of the rendered model but accessed and used in JSP via separate taglibs like spring security tags will have to be added to the model. For example, this convenience method `addContextInfoToModel(ModelAndView model)` in [`ControllerHelper.java`](https://github.com/OpenTechStrategies/psm/blob/master/psm-app/cms-web/src/main/java/gov/medicaid/controllers/ControllerHelper.java) should be used in each controller to add context data to the model passed to the view, for example in [UserController.java](https://github.com/OpenTechStrategies/psm/blob/3fd8a0a14fc802cb7a5061eddc5109c091ecb85d/psm-app/cms-web/src/main/java/gov/medicaid/controllers/admin/UserController.java]) we do

```java
model.addObject("user", user);
ControllerHelper.addContextInfoToModel(model);
```

### 2. Includes

For example, this include that also needs to set a variable:

```xml
<c:set var="title" value="Update Profile (Service Admin)"/>
<%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
```

In handlebars would be:

```mustache
{{> admin/includes/html_head title="Update Profile (Service Admin)" }}
```

### 3. "Logic-less" templates

With *handlebars* we can use *if, else if, else* and other block extensions; however this means the arguments for *if* are variables that exist and have a non-false or non-empty (if a collection) value. No expressions will be evaluated, for example, `{{#if foo == 42}}…` is invalid, you can use only `{{#if foo}}…`

For example, this fragment of JSP from `includes/nav.jsp`

```xml
<li class="${activeTab == 1 ? 'active' : ''}">
  <a href="<c:url value="/landing" />">DASHBOARD</a>
  <c:if test="${activeTab == 1}"><span class="arrow"></span></c:if>
</li>
```

which was included from an upstream template with

```xml
<c:set var="activeTab" value="1"></c:set>
<%@include file="/WEB-INF/pages/includes/nav.jsp" %>
```

was converted in this manner:

- In the upstream the include setting a non-false variable value for the desired tab, instead of a numerical value for a tab:

```mustache
{{> includes/nav activeTab1=1 }}
```

- while `nav.template.html` was converted as such:

```mustache
<li class="{{#if activeTab1 }} active {{/if}}">
  <a href="{{ctx}}/landing">DASHBOARD</a>
  {{#if activeTab1 }} <span class="arrow"></span> {{/if}}
</li>

<li class="{{#if activeTab2 }} active {{/if}}">
  <a href="{{ctx}}/provider/dashboard/drafts">ENROLLMENTS</a>
  {{#if activeTab2 }} <span class="arrow"></span> {{/if}}
</li>

[...]
```
