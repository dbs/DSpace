<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%
    String analyticsUrl = ConfigurationManager.getProperty("jspui.matomo.analytics.url");
    String analyticsSite = ConfigurationManager.getProperty("jspui.matomo.analytics.site");
%>
<!-- Matomo analytics -->
    <%
    if (analyticsUrl != null && analyticsUrl.length() > 0)
    {
    %>
      <script type="text/javascript">
        var _paq = window._paq || [];
        /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
        _paq.push(['trackPageView']);
        _paq.push(['enableLinkTracking']);
        (function() {
          var u="<%= analyticsUrl %>";
          _paq.push(['setTrackerUrl', u+'matomo.php']);
          _paq.push(['setSiteId', '<%= analyticsSite %>']);
          var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
          g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
        })();
      </script>
    <%
    }
    %>
