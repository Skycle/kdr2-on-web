<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0"
     xmlns:content="http://purl.org/rss/1.0/modules/content/"
     xmlns:wfw="http://wellformedweb.org/CommentAPI/"
     xmlns:dc="http://purl.org/dc/elements/1.1/"
     xmlns:atom="http://www.w3.org/2005/Atom"
     xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
     xmlns:slash="http://purl.org/rss/1.0/modules/slash/"
     >

  <channel>
    <title>KDr2</title>
    <atom:link href="http://kdr2.net/service/feed/rss" rel="self" type="application/rss+xml" />
    <link>http://kdr2.net</link>
    <description>KDr2's Personal Site.</description>
    <lastBuildDate>Tue, 22 Dec 2009 02:15:47 +0000</lastBuildDate>

    <generator>KDr2's Persnal Site</generator>
    <language>en</language>
    <sy:updatePeriod>hourly</sy:updatePeriod>
    <sy:updateFrequency>1</sy:updateFrequency>

    % for item in c.item_list:

    <item>
      <title>${item['title']}</title>

      <link>${item['link']}</link>
      <!-- comments>http://link#comments</comments -->
      <pubDate>${item['pubdate']}</pubDate>
      <dc:creator>${item['author']}</dc:creator>

      <category><![CDATA[${item['cats']}]]></category>

      <guid isPermaLink="false">${item['link']}</guid>
      <description>
        <![CDATA[${item['desc']}]]>
      </description>
      <content:encoded>
        <![CDATA[${item['content']}]]>
      </content:encoded>
      <!-- wfw:commentRss>none/feed/</wfw:commentRss -->
      <!-- slash:comments>0</slash:comments -->
    </item>

    % endfor

  </channel>
</rss>