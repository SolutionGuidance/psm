<%@ tag import="java.util.*" %>
<%@ tag import="com.github.jknack.handlebars.io.TemplateLoader" %>
<%@ tag import="com.github.jknack.handlebars.io.ServletContextTemplateLoader" %>
<%@ tag import="com.github.jknack.handlebars.Handlebars" %>
<%@ tag import="com.github.jknack.handlebars.Template" %>
<%@ tag import="com.github.jknack.handlebars.Context" %>
<%@ attribute name="template" required="true" %>
<%@ attribute name="context" required="true" type="javax.servlet.jsp.PageContext" %>
<%
JspContext jspContext = getJspContext();

TemplateLoader loader = new ServletContextTemplateLoader(
  ((PageContext) jspContext).getServletContext(),
  "/templates",
  ".template.html");

try {
  Handlebars handlebars = new Handlebars(loader);
  Template t = handlebars.compile(jspContext.getAttribute("template").toString());
  Map map = new HashMap();

  // parent page context, passed via attr
  PageContext parentContext = (PageContext) jspContext.getAttribute("context");
  Enumeration attrs = parentContext.getAttributeNamesInScope(PageContext.PAGE_SCOPE);

  while(attrs.hasMoreElements()) {
      String name = attrs.nextElement().toString();

      // replicate attrs into current context too
      map.put(name, parentContext.getAttribute(name));
      jspContext.setAttribute(name, parentContext.getAttribute(name), PageContext.PAGE_SCOPE);
  }

  Context context = Context.newBuilder(map).build();

  %><%= t.apply(context) %><%

  context.destroy();
} catch (Exception e) {
  %><%= e %><%
}
%>
