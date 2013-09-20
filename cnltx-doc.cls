% --------------------------------------------------------------------------
% the CNLTX bundle
%
%   LaTeX source code and output
%
% --------------------------------------------------------------------------
% Clemens Niederberger
% Web:    https://github.com/cgnieder/cnltx/
% E-Mail: contact@mychemistry.eu
% --------------------------------------------------------------------------
% Copyright 2013 Clemens Niederberger
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Clemens Niederberger.
% --------------------------------------------------------------------------
% If you have any ideas, questions, suggestions or bugs to report, please
% feel free to contact me.
% --------------------------------------------------------------------------
\RequirePackage{cnltx-base}
\ProvidesClass{cnltx-doc}[\cnltx@@date\space \cnltx@@version\space
 \cnltx@@info]

\cnltx@create@message*{doc}{Error}
\cnltx@create@message*{doc}{Warning}
\cnltx@create@message*{doc}{WarningNoLine}
\cnltx@create@message*{doc}{Info}

\newbool{cnltx@load@preamble}
\newbool{cnltx@add@index}
\newbool{cnltx@add@bib}

\def\cnltx@scrartcl@options{}
\def\cnltx@babel@options{english}


\pgfkeys{
  cnltx-doc/.cd,
    scrartcl/.code       = \PassOptionsToClass{#1}{scrartcl} ,
    load-preamble/.is if = cnltx@load@preamble ,
    add-index/.is if     = cnltx@add@index ,
    add-bib/.is if       = cnltx@add@bib ,
    load-preamble+/.code =
      \booltrue{cnltx@load@preamble}
      \booltrue{cnltx@add@index}
      \booltrue{cnltx@add@bib} ,
    babel-options/.code  = \def\cnltx@babel@options{#1}
}

\ProcessPgfOptions{/cnltx-doc}

\let\@classoptionslist\relax
\LoadClass{scrartcl}


\def\cnltx@index@prologue{}
\newbool{cnltx@index@prologue}
\newlength\cnltx@index@space

\def\cnltx@index@setup{othercode=\footnotesize,level=\addsec}
\def\cnltx@makeindex@setup{columns=2,columnsep=1em}
\def\cnltx@index@style{cnltx.ist}

\pgfkeys{
  cnltx/.cd,
    index-prologue/.code  =
      \def\cnltx@index@prologue{#1}
      \booltrue{cnltx@index@prologue} ,
    index-space/.code     = \setlength\cnltx@index@space{#1} ,
    index-setup/.code     = \def\cnltx@index@setup{#1} ,
    makeindex-setup/.code = \def\cnltx@makeindex@setup{#1} ,
    index-style/.code     = \def\cnltx@index@style{#1}
}


\RequirePackage{cnltx-tools,cnltx-example,cnltx-listings,translations}

\def\cnltx@caption@font{\normalfont\small\sffamily}
\def\cnltx@captionlabel@font{\cnltx@caption@font\scshape}

\pgfkeys{
  cnltx/.cd,
    caption-font/.code = \def\cnltx@caption@font{#1} ,
    caption-label-font/.code = \def\cnltx@captionlabel@font{#1}
}

\ifbool{cnltx@load@preamble}{
  \RequirePackage{ifxetex,ifluatex}
  \ifboolexpr{not bool{xetex} and not bool{luatex}}
    {\RequirePackage[T1]{fontenc}}
    {\RequirePackage{fontspec}}
  \RequirePackage[oldstyle]{libertine}
  \RequirePackage{libertinehologopatch}
  \RequirePackage[supstfm=libertinesups]{superiors}
  \RequirePackage{microtype}
  \ifboolexpr{not bool{xetex} and not bool{luatex}}
    {\RequirePackage[scaled=.81]{beramono}}
    {\setmonofont[Scale=MatchLowercase]{Bitstream Vera Sans Mono}}
  \RequirePackage{fnpct}
  \expandafter\RequirePackage\expandafter[\cnltx@babel@options]{babel}
  \renewcommand*\othersectionlevelsformat[3]{%
    \textcolor{cnltx}{#3\autodot}\enskip}
  \renewcommand*\partformat{%
    \textcolor{cnltx}{\partname~\thepart\autodot}}
  \deffootnote{2em}{1em}{\llap{\thefootnotemark. }}%
  \pagestyle{headings}
  \setcapindent{1.5em}
  \setkomafont{caption}{\cnltx@caption@font}
  \setkomafont{captionlabel}{\cnltx@captionlabel@font}
}{}

\ifbool{cnltx@add@index}{
  \RequirePackage[
    backend=biber,
    style=cnltx,
    sortlocale=en_EN,
    indexing=cite,
    useprefix]{biblatex}
  \addbibresource{cnltx.bib}
  \AtEndDocument{\printbibliography}
}{}

\ifbool{cnltx@add@index}{
  \AtEndPreamble{%
    \RequirePackage{imakeidx}
    \expandafter\indexsetup\expandafter{\cnltx@index@setup}
    \expandafter\makeindex\expandafter
      [\cnltx@makeindex@setup,options={-s \cnltx@index@style}]
    \AtEndDocument{%
      \ifbool{cnltx@index@prologue}{%
        \indexprologue
          [\vspace{\cnltx@index@space}]
          {\noindent\cnltx@index@prologue}
      }{}%
      \printindex
    }%
  }
}{}

\AtBeginDocument{%
  \immediate\write\@auxout{%
    \unexpanded{%
      \ifx\texorpdfstring\@undefined^^J
        \providecommand\texorpdfstring[2]{#1}^^J
        \providecommand\pdfstringdefDisableCommands[1]{}^^J
        \providecommand\nohyperpage[1]{#1}^^J
      \fi
    }%
  }%
}

% --------------------------------------------------------------------------
% license information:
% define those differently:
\newcommand*\lppl{\cnltx@acronym{LPPL}{lppl}}
\newcommand*\LPPL{%
  \LaTeX{} Project Public License%
  \index{LPPL@{\cnltx@acronym@format lppl}}%
}

\newrobustcmd*\license{\@ifstar{\cnltx@license}{\cnltx@license\cnltx@par}}
\newcommand\cnltx@license[1][maintained]{%
  \GetTranslation{cnltx-license} ``#1.''%
}

% CTAN:
\newcommand*\ctan{\cnltx@acronym{CTAN}{ctan}}
\newcommand*\CTAN{%
  Comprehensive \TeX\ Archive Network%
  \index{CTAN@{\cnltx@acronym@format ctan}}%
}

% --------------------------------------------------------------------------
% package information:
\def\cnltx@getfileinfo#1#2{%
  \def\@tempb##1 ##2 ##3\relax##4\relax{%
    \gdef\cnltx@package@date{##1}%
    \gdef\cnltx@package@version{##2}%
    \gdef\cnltx@package@info{##3}}%
  \edef\@tempa{\csname ver@#1.#2\endcsname}%
  \expandafter\@tempb\@tempa\relax? ? \relax\relax}

\def\cnltx@package@name{??}
\newbool{cnltx@package@name}
\def\cnltx@package@date{??}
\def\cnltx@package@version{??}
\def\cnltx@package@info{??}
\def\cnltx@package@title{??}
\def\cnltx@title@format{\bfseries\scshape}
\newbool{cnltx@package@title}
\def\cnltx@package@subtitle{??}
\newbool{cnltx@package@subtitle}
\def\cnltx@package@url{??}
\newbool{cnltx@package@url}
\def\cnltx@package@email{??}
\newbool{cnltx@package@email}
\def\cnltx@package@abstract{??}
\newbool{cnltx@package@abstract}

\def\cnltx@package@name@format#1{\textcolor{cnltx}{\textsc{#1}}}

\def\cnltx@newpackagename#1#2{%
  \newcommand*#1{\cnltx@package@name@format{#2}}%
}
\newrobustcmd*\newpackagename{\cnltx@newpackagename}

% --------------------------------------------------------------------------
% authors:
\def\cnltx@package@author@list{}
\def\cnltx@package@author@pdflist{}
\def\cnltx@new@author#1{%
  \listadd\cnltx@package@author@list
    {\cnltx@read@name{#1}}%
  \listadd\cnltx@package@author@pdflist
    {\cnltx@extract@name{#1}}%
}

% writing the names and email addresses:
\def\cnltx@read@name#1{%
  \cnltx@read@name@aux#1[]\q@stop
}
\def\cnltx@read@name@aux#1[#2]\q@stop{%
  \cnltx@get@first@and@second@name#1 \q@stop
  \ifblank{#2}{}
    {\cnltx@write@author@email#2\q@stop}%
}
\def\cnltx@write@author@email#1][\q@stop{%
  \ifblank{#1}{}
    {\footnote{\href{mailto:#1}{#1}}}%
}
\def\cnltx@get@first@and@second@name#1 #2\q@stop{%
  \ifblank{#2}
    {%
      \cnltx@name[]{#1}%
      \listgadd\cnltx@package@author@pdflist{#1}%
    }
    {%
      \cnltx@name[#1]{\trim@spaces{#2}}%
      \listgadd\cnltx@package@author@pdflist{#1 \trim@spaces{#2}}%
    }%
}

% getting the names for the pdf properties:
\def\cnltx@extract@name#1{%
  \cnltx@extract@name@aux#1[]\q@stop
}
\def\cnltx@extract@name@aux#1[#2]\q@stop{%
  #1\ifblank{#2}{}{\cnltx@extract@name@aux@i#2\q@stop}, %
}
\def\cnltx@extract@name@aux@i#1][\q@stop{}

\def\cnltx@package@authors{%
  \gdef\cnltx@author@sep{\gdef\cnltx@author@sep{\qquad}}%
  \forlistloop{\cnltx@author@sep}\cnltx@package@author@list
}


% --------------------------------------------------------------------------
% options:
\pgfkeys{
  cnltx/.cd,
    package/.code =
      \ifcsdef{#1}{}{\expandafter\newpackagename\csname#1\endcsname{#1}}
      \gdef\cnltx@package@name{#1}
      \@ifpackageloaded{#1}
        {\cnltx@getfileinfo{#1}{sty}}
        {\cnltx@doc@warning{Package `#1' is not loaded, yet!}}
      \booltrue{cnltx@package@name} ,
    class/.code =
      \ifcsdef{#1}{}{\expandafter\newpackagename\csname#1\endcsname{#1}}
      \gdef\cnltx@package@name{#1}
      \@ifclassloaded{#1}
        {\cnltx@getfileinfo{#1}{cls}}
        {\cnltx@doc@warning{Class `#1' is not loaded, yet!}}
      \booltrue{cnltx@package@name} ,
    name/.code =
      \ifcsdef{#1}{}{\expandafter\newpackagename\csname#1\endcsname{#1}}
      \gdef\cnltx@package@name{#1}
      \booltrue{cnltx@package@name} ,
    title/.code =
      \gdef\cnltx@package@title{#1}
      \booltrue{cnltx@package@title} ,
    title-format/.code =
      \def\cnltx@title@format{#1} ,
    build-title/.is if = cnltx@package@title ,
    subtitle/.code =
      \gdef\cnltx@package@subtitle{#1}
      \booltrue{cnltx@package@subtitle} ,
    authors/.code =
      \gdef\cnltx@package@author@list{}
      \forcsvlist{\cnltx@new@author}{#1} ,
    date/.code = \gdef\cnltx@package@date{#1} ,
    version/.code = \gdef\cnltx@package@version{#1} ,
    info/.code = \gdef\cnltx@package@info{#1} ,
    url/.code =
      \gdef\cnltx@package@url{#1}
      \booltrue{cnltx@package@url} ,
    email/.code =
      \gdef\cnltx@package@email{#1}
      \booltrue{cnltx@package@email} ,
    abstract/.code =
      \gdef\cnltx@package@abstract{\parbox{.75\linewidth}{#1}}
      \booltrue{cnltx@package@abstract} ,
}
% --------------------------------------------------------------------------
% command descriptions:
\def\cnltx@command{%
  \@ifstar
    {\cnltx@command@star}
    {\cnltx@command@nostar}%
}

\def\cnltx@command@star#1{%
  \@ifnextchar[
    {\cnltx@command@star@opt{#1}}
    {\cnltx@command@star@opt{#1}[]}%
}

\def\cnltx@command@nostar#1{%
  \@ifnextchar[
    {\cnltx@command@nostar@opt{#1}}
    {\cnltx@command@nostar@opt{#1}[]}%
}

\def\cnltx@command@star@opt#1[#2]{%
  \ifblank{#2}
    {\item\cs*{#1}}
    {\item\cs*{#1}#2}%
  \cnltx@checkdefault{\hfill\newline}%
}
\def\cnltx@command@nostar@opt#1[#2]{%
  \ifblank{#2}
    {\item\cs{#1}}
    {\item\cs{#1}#2}%
  \cnltx@checkdefault{\hfill\newline}%
}

\newcommand\cnltx@checkdefault[1]{%
  \@ifnextchar\Module
    {}
    {%
      \@ifnextchar\Default
        {}
        {%
          \@ifnextchar\default
            {}
            {#1}%
        }%
    }%
}

\def\cmltx@list@setup{%
  \leftmargin=0pt
  \labelwidth=2em
  \labelsep=0pt
  \itemindent=-1em
}

\pgfkeys{
  cnltx/.cd,
    list-setup/.code = \def\cmltx@list@setup{#1}
}

\newenvironment{cnltxlist}
  {\list{}{\cmltx@list@setup}}
  {\endlist}

\newenvironment{commands}
  {%
    \let\command\cnltx@command
    \cnltxlist
  }
  {\endcnltxlist}

% --------------------------------------------------------------------------
% option descriptions:
\def\@cnltx@option@item#1{%
  \@ifstar
    {\@cnltx@option@item@aux@star{#1}}
    {\@cnltx@option@item@aux@nostar{#1}}%
}

\def\@cnltx@option@item@aux@star#1{%
  \cnltx@ifdash
    {\@cnltx@option@item@aux{#1}*-}
    {\@cnltx@option@item@aux{#1}*{}}%
}
\def\@cnltx@option@item@aux@nostar#1{%
  \cnltx@ifdash
    {\@cnltx@option@item@aux{#1}{}-}
    {\@cnltx@option@item@aux{#1}{}{}}%
}

\def\@cnltx@option@item@aux#1#2#3#4{%
  \@ifnextchar\bgroup
    {\@cnltx@option@two{#1#2#3}{#4}}
    {\@cnltx@option@one{#1#2#3}{#4}}%
}

\def\@cnltx@option@one#1#2{%
  \item#1{#2}%
  \cnltx@checkdefault{\hfill\newline}%
}

\def\@cnltx@option@two#1#2#3{%
  \item#1{#2}{#3}%
  \cnltx@checkdefault{\hfill\newline}%
}

\newenvironment{options}
  {%
    \def\opt{\@cnltx@option@item\option}%
    \def\keyval{\@cnltx@option@item\key}%
    \def\keylit{\@cnltx@option@item\keyis}%
    \def\keychoice{\@cnltx@option@item\choicekey}%
    \def\keybool{\@cnltx@option@item\boolkey}%
    \cnltxlist
  }
  {\endcnltxlist}

% --------------------------------------------------------------------------
% environment descriptions:
\def\cnltx@environment{%
  \@ifstar
    {\cnltx@environment@star}
    {\cnltx@environment@nostar}%
}

\def\cnltx@environment@star#1{%
  \@ifnextchar[
    {\cnltx@environment@star@opt{#1}}
    {\cnltx@environment@star@opt{#1}[]}%
}

\def\cnltx@environment@nostar#1{%
  \@ifnextchar[
    {\cnltx@environment@nostar@opt{#1}}
    {\cnltx@environment@nostar@opt{#1}[]}%
}

\def\cnltx@environment@star@opt#1[#2]{%
  \ifblank{#2}
    {\item\beginenv*\code{\{}\env*{#1}\code{\}}}
    {\item\beginenv*\code{\{}\env*{#1}\code{\}}#2}%
  \cnltx@checkdefault{\hfill\newline}%
}
\def\cnltx@environment@nostar@opt#1[#2]{%
  \ifblank{#2}
    {\item\beginenv*\code{\{}\env{#1}\code{\}}}
    {\item\beginenv*\code{\{}\env{#1}\code{\}}#2}%
  \cnltx@checkdefault{\hfill\newline}%
}

\newenvironment{environments}
  {%
    \let\environment\cnltx@environment
    \cnltxlist
  }
  {\endcnltxlist}

% --------------------------------------------------------------------------
% default values:
\def\cnltx@Default#1{%
  \null\hfill
  \@ifnextchar\bgroup
    {\cnltx@Default@initial{#1}}
    {%
      \cnltx@ifbang
        {\cnltx@Default@required{#1}}
        {\cnltx@Default@empty{#1}}%
    }%
}

\def\cnltx@Default@initial#1#2{%
  \llap{\GetTranslation{cnltx-default}: \code{#2}}%
  \ifblank{#1}{\newline}{}%
}

\def\cnltx@Default@required#1{%
  \llap{(\GetTranslation{cnltx-required})}%
  \ifblank{#1}{\newline}{}%
}

\def\cnltx@Default@empty#1{%
  \llap{(\GetTranslation{cnltx-empty})}%
  \ifblank{#1}{\newline}{}%
}

\newrobustcmd\Default{%
  \@ifstar
    {\cnltx@Default{*}}
    {\cnltx@Default{}}%
}

\newrobustcmd*\expandable{\cnltx@expandable@ornot\cnltx@expandable}
\newrobustcmd*\unexpandable{\cnltx@expandable@ornot\cnltx@unexpandable}

\def\cnltx@expandable@ornot#1{%
  \let\cnltx@item\item
  \def\item{\cnltx@item#1\let\item\cnltx@item}%
}
\def\cnltx@expandable@note#1{%
  \begingroup
    \reversemarginpar
    \marginnote{\hfill#1\space}%
  \endgroup
}
\def\cnltx@expandable{%
  \cnltx@expandable@note{%
    \textcolor{expandable}{\expandablesign}%
  }%
}
\def\cnltx@unexpandable{%
  \cnltx@expandable@note{%
    \textcolor{unexpandable}{\expandablesign}%
  }%
}

\def\expandablesign{\textasteriskcentered}

\pgfkeys{
  cnltx/.cd,
    expandable-sign/.code = \def\expandablesign{#1}
}

% --------------------------------------------------------------------------
% modules:
\def\cnltx@module@sep{ >> }
\pgfkeys{
  cnltx/.cd,
    module-sep/.code = \def\cnltx@module@sep{#1}
}

\def\cnltx@module#1{%
  \cnltx@ifbang
    {\cnltx@write@module{#1}{}}
    {\cnltx@write@module{#1}{*}}%
}
\def\cnltx@write@module#1#2#3{
  \cnltx@module@text{#2}{#3}%
  \ifblank{#1}{\cnltx@checkdefault{\hfill\newline}}{}%
}
\def\cnltx@module@text#1#2{%
  \begingroup
    \reversemarginpar
    \marginnote{\hfill\module#1{#2}\cnltx@module@sep}%
  \endgroup
}
  
\newrobustcmd*\Module{%
  \@ifstar
    {\cnltx@module{*}}
    {\cnltx@module{}}%
}

% --------------------------------------------------------------------------
% a environment for block quotes
\def\cnltx@quote@author@format{\itshape}
\def\cnltx@quote@format{\small\sffamily}

\pgfkeys{
  cnltx/.cd ,
    quote-format/.code        = \def\cnltx@quote@format{#1} ,
    quote-author-format/.code = \def\cnltx@quote@author@format{#1}
}

\newenvironment{cnltxquote}[1][]
  {%
    \def\cnltx@quote@option{#1}%
    \quote
    \cnltx@quote@format
  }
  {%
    \ifdefempty\cnltx@quote@option
      {}
      {%
        \unskip\nobreak\hfil\penalty50
        \hskip2em\hbox{}\nobreak\hfil
        {\normalfont\cnltx@quote@author@format\cnltx@quote@option}%
        \parfillskip0pt \finalhyphendemerits=0
        \par
      }%
    \endquote
  }

% --------------------------------------------------------------------------
% document title:
\AfterPackage!{hyperref}{%
  \newrobustcmd*\cnltx@tableofcontents{%
    \begingroup
      \let\tocbasic@listhead\@gobble
      \tableofcontents
    \endgroup
  }%
  \RequirePackage{multicol}
  \AtBeginDocument{%
    \ifbool{cnltx@package@name}
      {\cnltx@title@information}
      {%
        \cnltx@doc@warning{%
          No package/class name given. Hence I won't create an
          automatic title%
        }%
      }%
  }%
}

\def\cnltx@title@information{%
  \thispagestyle{plain}
  \begin{center}
    \ifbool{cnltx@load@preamble}{}
      {\renewcommand\thefootnote{\@fnsymbol\c@footnote}}%
    \Huge
    \scalebox{1.5}{%
      \color{cnltx}%
      \cnltx@title@format
      \ifbool{cnltx@package@title}
        {\cnltx@package@title}
        {\cnltx@package@name}%
    }%
    \par\vskip.5cm\relax
    \large
    \ifbool{cnltx@package@subtitle}
      {\cnltx@package@subtitle\par\vskip.5cm\relax}
      {}%
    \Large \cnltx@package@version \qquad \cnltx@package@date
    \par\vskip.5cm\relax
    \large
    \cnltx@package@info
    \par\vskip.5cm\relax
    \large
    \cnltx@package@authors
    \normalsize
    \ifbool{cnltx@package@url}
      {%
        \par\vskip.5cm\relax
        \url{\cnltx@package@url}%
      }{}%
    \ifbool{cnltx@package@email}
      {%
        \par\vskip.5cm\relax
        \href{mailto:\cnltx@package@email}{\cnltx@package@email}%  
      }{}%
    \ifbool{cnltx@package@abstract}
      {%
        \par\vskip.5cm\relax
        \cnltx@package@abstract
      }{}%
  \end{center}
  \begin{multicols}{2}[\section*{\GetTranslation{cnltx-toc}}]
    \cnltx@tableofcontents
  \end{multicols}%
}

% --------------------------------------------------------------------------
% versioning:
\RequirePackage{marginnote,ragged2e}
\newcommand*\versionnoteformat{\footnotesize\sffamily\RaggedRight}

\pgfkeys{
  cnltx/.cd,
    version-note-format/.code = \renewcommand*\versionnoteformat{#1} ,
}

\long\def\cnltx@version@note#1{%
  \@bsphack
  \begingroup
    \reversemarginpar
    \marginnote
      {%
        \versionnoteformat
        \textcolor{versionnote}{#1}%
      }%
    \endgroup
  \@esphack
}

\def\cnltx@newnote{%
  \@ifstar
    {\cnltx@newnote@aux{*}}
    {\cnltx@newnote@aux{}}%
}

\def\cnltx@newnote@aux#1#2{%
  \@ifnextchar[%]
    {\cnltx@newnote@aux@i{#1}{#2}}
    {\cnltx@newnote@aux@i{#1}{#2}[0]}%
}
\long\def\cnltx@newnote@aux@i#1#2[#3]#4{%
  \ifblank{#1}
    {\newrobustcmd#2[#3]{\cnltx@version@note{#4}}}
    {\newrobustcmd*#2[#3]{\cnltx@version@note{#4}}}%
}

\newrobustcmd\newnote{\cnltx@newnote}

\newnote*\sinceversion[1]{\GetTranslation{cnltx-introduced}~#1}
\newnote*\changedversion[1]{\GetTranslation{cnltx-changed}~#1}

% --------------------------------------------------------------------------
% hyperlinks:
\newrobustcmd*\CTANurl[2][macros/latex/contrib]{%
  on \ctan\ as \code{#2}: \url{http://mirrors.ctan.org/#1/#2/}%
}

\newrobustcmd*\needpackage[2][macros/latex/contrib]{%
  \pkg{#2}\footnote{\CTANurl[#1]{#2}}%
}

\newrobustcmd*\needclass[2][macros/latex/contrib]{%
  \cls{#2}\footnote{\CTANurl[#1]{#2}}%
}

\AtEndPreamble{%
  \RequirePackage{hyperref}%
  \pdfstringdefDisableCommands{%
    \def\cnltx@name[#1]#2{#1 #2, }%
  }%
  \hypersetup
    {
      colorlinks         = true,
      allcolors          = link ,
      plainpages         = false,
      bookmarksopen      = true,
      bookmarksopenlevel = 1,
      bookmarksnumbered  = true,
      pdfauthor          = {\forlistloop{}\cnltx@package@author@pdflist},
      pdftitle           =
        {\cnltx@package@name\space\cnltx@package@version\space Manual},
      pdfsubject         = {\cnltx@package@info},
      pdfstartview       = FitH
    }%
}

% --------------------------------------------------------------------------
% localization strings:
\DeclareTranslationFallback{cnltx-default}{Default}
\DeclareTranslation{English}{cnltx-default}{Default}
\DeclareTranslation{German}{cnltx-default}{Voreinstellung}

\DeclareTranslationFallback{cnltx-required}{required}
\DeclareTranslation{English}{cnltx-required}{required}
\DeclareTranslation{German}{cnltx-required}{erforderlich}

\DeclareTranslationFallback{cnltx-empty}{initially empty}
\DeclareTranslation{English}{cnltx-empty}{initially empty}
\DeclareTranslation{German}{cnltx-empty}{zun\"achst leer}

\DeclareTranslationFallback{cnltx-toc}{Table of Contents}
\DeclareTranslation{English}{cnltx-toc}{Table of Contents}
\DeclareTranslation{German}{cnltx-toc}{Inhaltsverzeichnis}

\DeclareTranslationFallback{cnltx-license}{%
  Permission is granted to copy, distribute and/or modify this software under
  the terms of the \LPPL\ (\lppl), version 1.3 or later
  (\url{http://www.latex-project.org/lppl.txt}). The software has the status%
}
\DeclareTranslation{English}{cnltx-license}{%
  Permission is granted to copy, distribute and/or modify this software under
  the terms of the \LPPL\ (\lppl), version 1.3 or later
  (\url{http://www.latex-project.org/lppl.txt}). The software has the status%
}
\DeclareTranslation{German}{cnltx-license}{%
  Es ist erlaubt, diese Software zu kopieren und zu verteilen unter den
  Bedingungen der \LPPL\ (\lppl), Version 1.3 oder sp\"ater.
  (\url{http://www.latex-project.org/lppl.txt}). Sie hat den Status%
}

\DeclareTranslationFallback{cnltx-introduced}{Introduced in version}
\DeclareTranslation{English}{cnltx-introduced}{Introduced in version}
\DeclareTranslation{German}{cnltx-introduced}{Eingef\"uhrt in Version}

\DeclareTranslationFallback{cnltx-changed}{Changed in version}
\DeclareTranslation{English}{cnltx-changed}{Changed in version}
\DeclareTranslation{German}{cnltx-changed}{Ge\"andert in Version}

\DeclareTranslationFallback{cnltx-f.}{f.}
\DeclareTranslation{English}{cnltx-f.}{f.}
\DeclareTranslation{German}{cnltx-f.}{f.}

\DeclareTranslationFallback{cnltx-ff.}{ff.}
\DeclareTranslation{English}{cnltx-ff.}{ff.}
\DeclareTranslation{German}{cnltx-ff.}{ff.}

\DeclareTranslationFallback{cnltx-maintainer}{current maintainer}
\DeclareTranslation{English}{cnltx-maintainer}{current maintainer}
\DeclareTranslation{German}{cnltx-maintainer}{aktueller Maintainer}

\DeclareTranslationFallback{cnltx-maintainers}{current maintainers}
\DeclareTranslation{English}{cnltx-maintainers}{current maintainers}
\DeclareTranslation{German}{cnltx-maintainers}{aktuelle Maintainer}

\endinput

% --------------------------------------------------------------------------
HISTORY:

2013/09/08 v0.1  - first working version
2013/09/10 v0.2  - added optional argument to \license
                 - \newname got moved to `cnltx-tools'
                 - added possibility for internationalization
                 - new macros \needpackage and \needclass
                 - option for formatting the document title
2013/09/12 v0.3  - new class options `add-index', `load-preamble+' and
                   `scrartcl'
                 - new options `index-prologue' and `index-space'
                 - new file `cnltx.ist'
                 - added \Module
                 - added optional ! to the \Default command
                 - add safety net: provide necessary commands in the aux-file
                   if they're not defined at begin document
2013/09/12 v0.3a - automatic preamble detects xelatex and lualatex and selects
                   the fonts accordingly
2013/09/15 v0.4  - possiblity to add an email address for each author, written
                   as footnote; they get symbols if the `load-preamble'
                   options is not used
                 - fixed bug in index setup mechanism
                 - added biblatex entry type `package' and biblatex style
                   `cnltx'
2013/09/20 v0.5  - new commands \expandable and \unexpandable
                 - new environment `cnltxquote', formatting via options
                   `quote-format' and `quote-author-format'
                 - changed scaling of `beramono' from `.83' to `.81' -- seems
                   a better fit in relation to Linux Libertine

% --------------------------------------------------------------------------
TODO:

