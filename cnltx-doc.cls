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
% The cnltx bundle consists of the files
%  - cnltx-base.sty, cnltx-example.sty cnltx-doc.cls, cnltx-csnames.sty,
%    cnltx-tools.sty
%  - cnltx_en.tex, cnltx_en.pdf
%  - README
% --------------------------------------------------------------------------
% If you have any ideas, questions, suggestions or bugs to report, please
% feel free to contact me.
% --------------------------------------------------------------------------
\RequirePackage{cnltx-base}
\ProvidesClass{cnltx-doc}[\cnltx@@date\space \cnltx@@version\space \cnltx@@info]
\LoadClassWithOptions{scrartcl}

\cnltx@create@message*{doc}{Error}
\cnltx@create@message*{doc}{Warning}
\cnltx@create@message*{doc}{WarningNoLine}
\cnltx@create@message*{doc}{Info}

\RequirePackage{cnltx-tools,cnltx-example}
\RequirePackage{translations}

\newbool{cnltx@load@preamble}
\DeclareOption{load-preamble}{\booltrue{cnltx@load@preamble}}

% \DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

\ifbool{cnltx@load@preamble}{
  \RequirePackage[oldstyle]{libertine}
  \RequirePackage{libertinehologopatch}
  \RequirePackage[supstfm=libertinesups]{superiors}
  \RequirePackage{microtype}
  \RequirePackage[scaled=.83]{beramono}
  \RequirePackage{fnpct}
  \RequirePackage[english]{babel}
  \renewcommand*\othersectionlevelsformat[3]{%
    \textcolor{cnltx}{#3\autodot}\enskip}
  \renewcommand*\partformat{%
    \textcolor{cnltx}{\partname~\thepart\autodot}}
  \deffootnote{2em}{1em}{\llap{\thefootnotemark. }}%
  \pagestyle{headings}
  \setcapindent{1.5em}
  \setkomafont{caption}{\normalfont\footnotesize\sffamily}
  \setkomafont{captionlabel}{\normalfont\footnotesize\sffamily\scshape}
}{}

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
\def\cnltx@new@author#1{%
  \listgadd\cnltx@package@author@list
    {\cnltx@read@name{#1}}%
}
\def\cnltx@read@name#1{%
  \cnltx@read@name@aux#1 \q@stop
}
\def\cnltx@read@name@aux#1 #2\q@stop{%
  \ifblank{#2}
    {\cnltx@name[]{#1}}
    {\cnltx@name[#1]{\trim@spaces{#2}}}%
}

\def\cnltx@package@authors{%
  \gdef\cnltx@author@sep{\gdef\cnltx@author@sep{, }}%
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
  \@ifnextchar\Default
    {}
    {%
      \@ifnextchar\default
        {}
        {#1}%
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
      \llap{(\GetTranslation{cnltx-empty})}%
      \ifblank{#1}{\newline}{}%
    }%
}

\def\cnltx@Default@initial#1#2{%
  \llap{\GetTranslation{cnltx-default}: \code{#2}}%
  \ifblank{#1}{\newline}{}%
}

\newrobustcmd\Default{%
  \@ifstar
    {\cnltx@Default{*}}
    {\cnltx@Default{}}%
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
    \par\vskip.5cm\relax
    \normalsize
    \ifbool{cnltx@package@url}
      {%
        \url{\cnltx@package@url}%
        \par\vskip.5cm\relax
      }{}%
    \ifbool{cnltx@package@email}
      {%
        \href{mailto:\cnltx@package@email}{\cnltx@package@email}%
        \par\vskip.5cm\relax
      }{}%
    \ifbool{cnltx@package@abstract}
      {\cnltx@package@abstract}{}%
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

% TODO: more link commands

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
      pdfauthor          = {\forlistloop{}\cnltx@package@author@list},
      pdftitle           =
        {\cnltx@package@name\space\cnltx@package@version\space Manual},
      pdfsubject         = {\cnltx@package@info},
      pdfstartview       = FitH
    }%
}



\DeclareTranslationFallback{cnltx-default}{Default}
\DeclareTranslation{English}{cnltx-default}{Default}
\DeclareTranslation{German}{cnltx-default}{Voreinstellung}

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

\endinput

% --------------------------------------------------------------------------
HISTORY:

2013/09/08 v0.1 - first working version
2013/09/10 v0.2 - added optional argument to \license
                - \newname got moved to `cnltx-tools'
                - added possibility for internationalization
                - new macros \needpackage and \needclass
                - option for formatting the document title

