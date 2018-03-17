
Welcome to Atom `org-mode` Package
==================================

The [org-mode](http://org-mode.org) application provides an astounding set of features that can literally<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup> change your life for the better!  

Below is just a very small subset of things you can do using a text file + org-mode + emacs:

-   Literate Programming<sup><a id="fnr.2" class="footref" href="#fn.2">2</a></sup><sup>, </sup><sup><a id="fnr.3" class="footref" href="#fn.3">3</a></sup> in over 30 languages.
-   Project, Task and Time Management.
-   Data Science
-   Reproducible Research
-   Create and maintain documentation<sup><a id="fnr.4" class="footref" href="#fn.4">4</a></sup> in multiple popular formats including PDF, HTML<sup><a id="fnr.5" class="footref" href="#fn.5">5</a></sup> and Markdown.
-   Track and synchronize data across heterogeneous paradigms, technologies and formats including source code, network diagrams, Infrastructure as Code, DevOps<sup><a id="fnr.6" class="footref" href="#fn.6">6</a></sup>, databases, servers and services.
-   Learn new skills and share complex ideas in a consistent repeatable way.

Let us begin our journey into a better future.


Road Map
--------

-   Provide org-mode syntax highlighting to allow Atom users to easily create and maintain documentation.


Specifications
--------------

<table id="orgdd9a270" border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Property-Name</th>
<th scope="col" class="org-left">Property-Value</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">name</td>
<td class="org-left">org-mode</td>
</tr>


<tr>
<td class="org-left">version</td>
<td class="org-left">0.3.12</td>
</tr>


<tr>
<td class="org-left">description</td>
<td class="org-left">Atom grammar for org-mode syntax</td>
</tr>


<tr>
<td class="org-left">keywords</td>
<td class="org-left">org, org-mode, org mode, orgmode, emacs, literate programming, literate devops, devops, reproducible research, documentation</td>
</tr>


<tr>
<td class="org-left">repository</td>
<td class="org-left"><https://github.com/melioratus/org-mode></td>
</tr>


<tr>
<td class="org-left">license</td>
<td class="org-left">MIT</td>
</tr>


<tr>
<td class="org-left">engines</td>
<td class="org-left">"atom": "&gt;=1.0.0 &lt;2.0.0"</td>
</tr>


<tr>
<td class="org-left">dependencies</td>
<td class="org-left">"coffeescript": "1.7.0", "coffeelint": "^1.10.1", "request": "^2.34.0", "season": "^5.0.2"</td>
</tr>
</tbody>
</table>


Files List
----------

-   [coffeelint.json](coffeelint.json)
-   [org-mode-spec.coffee](spec/org-mode-spec.coffee)
-   [org-mode.cson](grammars/org-mode.cson)
-   [org-mode.less](styles/org-mode.less)
-   [package.json](package.json)
-   [shell-unix-bash-org-mode.cson](grammars/shell-unix-bash-org-mode.cson)


Footnotes
=========

<sup><a id="fn.1" href="#fnr.1">1</a></sup> pun intended

<sup><a id="fn.2" href="#fnr.2">2</a></sup> <https://en.wikipedia.org/wiki/Literate_programming>

<sup><a id="fn.3" href="#fnr.3">3</a></sup> <http://kitchingroup.cheme.cmu.edu/blog/2014/03/27/Literate-programming-in-python-with-org-mode-and-noweb/>

<sup><a id="fn.4" href="#fnr.4">4</a></sup> <https://github.com/fniessen/refcard-org-mode>

<sup><a id="fn.5" href="#fnr.5">5</a></sup> <https://github.com/fniessen/org-html-themes>

<sup><a id="fn.6" href="#fnr.6">6</a></sup> <http://howardism.org/Technical/Emacs/literate-devops.html>
