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
%  - cnltx-base.sty, cnltx-example.sty cnltx-doc.cls, cnltx-csnames.sty
%  - cnltx_en.tex, cnltx_en.pdf
%  - README
% --------------------------------------------------------------------------
% If you have any ideas, questions, suggestions or bugs to report, please
% feel free to contact me.
% --------------------------------------------------------------------------
\RequirePackage{cnltx-base}
\ProvidesClass{cnltx-doc}[\cnltx@@date\space \cnltx@@version\space \cnltx@@info]
\LoadClassWithOptions{scrartcl}

\cnltx@create@message{doc}{Error}
\cnltx@create@message{doc}{Warning}
\cnltx@create@message{doc}{WarningNoLine}
\cnltx@create@message{doc}{Info}

\RequirePackage{cnltx-example}
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
\newcommand*\lppl{\textsc{lppl}\index{LPPL@\textsc{lppl}}}
\newcommand*\LPPL{\LaTeX{} Project Public License\index{LPPL@\textsc{lppl}}}

\def\cnltx@par{\par}

\newcommand\license{\@ifstar{\cnltx@license}{\cnltx@license\cnltx@par}}
\def\cnltx@license{%
  Permission is granted to copy, distribute and/or modify this software under
  the terms of the \LPPL, version 1.3 or later
  (\url{http://www.latex-project.org/lppl.txt}). The package has the status
  ``maintained.''%
}

% CTAN:
\newcommand*\ctan{\textsc{ctan}\index{CTAN@\textsc{ctan}}}
\newcommand*\CTAN{Comprehensive \TeX\ Archive Network\index{CTAN@\textsc{ctan}}}

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

% --------------------------------------------------------------------------
% authors an other names:
\newcommand*\cnltx@name@first[1]{#1}
\newcommand*\cnltx@name@last[1]{\textsc{#1}}
\newcommand*\cnltx@name@base[1]{#1}
\newcommand*\cnltx@name@idx[1]{\index{#1@#1}}
\newrobustcmd*\cnltx@name@star[2][]{%
  \ifblank{#1}
    {\cnltx@name@base{\cnltx@name@last{#2}}}
    {\cnltx@name@base{\cnltx@name@first{#1} \cnltx@name@last{#2}}}%
}
\newrobustcmd*\cnltx@name@nostar[2][]{%
  \ifblank{#1}
    {\cnltx@name@base{\cnltx@name@last{#2}}\cnltx@name@idx{#2}}
    {%
      \cnltx@name@base{\cnltx@name@first{#1} \cnltx@name@last{#2}}%
      \cnltx@name@idx{#2, #1}%
    }%
}
\def\cnltx@name{\@ifstar{\cnltx@name@star}{\cnltx@name@nostar}}
 
\newcommand*\cnltx@newname[3]{%
  \csdef{\cnltx@stripbs#1@short}{\cnltx@name@base{#3}\cnltx@name@idx{#3, #2}}%
  \csdef{\cnltx@stripbs#1@long}{\cnltx@name@base{#2 #3}\cnltx@name@idx{#3, #2}}%
  \newcommand*#1{\@ifstar{\csuse{\cnltx@stripbs#1@short}}{\csuse{\cnltx@stripbs#1@long}}}}

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
      \ifcsdef{#1}{}{\csdef{#1}{\cnltx@package@name@format{#1}}}
      \gdef\cnltx@package@name{#1}
      \@ifpackageloaded{#1}{\cnltx@getfileinfo{#1}{sty}}{}
      \booltrue{cnltx@package@name} ,
    class/.code =
      \ifcsdef{#1}{}{\csdef{#1}{\cnltx@package@name@format{#1}}}
      \gdef\cnltx@package@name{#1}
      \@ifclassloaded{#1}{\cnltx@getfileinfo{#1}{cls}}{}
      \booltrue{cnltx@package@name} ,
    name/.code =
      \ifcsdef{#1}{}{\csdef{#1}{\cnltx@package@name@format{#1}}}
      \gdef\cnltx@package@name{#1}
      \booltrue{cnltx@package@name} ,
    title/.code =
      \gdef\cnltx@package@title{#1}
      \booltrue{cnltx@package@title} ,
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
    {\@cnltx@option@item@aux{#1}{*}}
    {\@cnltx@option@item@aux{#1}{}}%
}

\def\@cnltx@option@item@aux#1#2#3{%
  \@ifnextchar\bgroup
    {\@cnltx@option@two{#1#2}{#3}}
    {\@cnltx@option@one{#1#2}{#3}}%
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
      \llap{(initially empty)}%
      \ifblank{#1}{\newline}{}%
    }%
}

\def\cnltx@Default@initial#1#2{%
  \llap{Default: \code{#2}}%
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
          automatic title%b
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
      \bfseries\scshape
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
  \begin{multicols}{2}[\section*{Table of Contents}]
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

\def\cnltx@version@note#1{%
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

\newrobustcmd\sinceversion[1]{%
  \cnltx@version@note{Introduced in version\nobreakspace #1}%
}

\newrobustcmd\changedversion[1]{%
  \cnltx@version@note{Changed in version\nobreakspace #1}%
}

% --------------------------------------------------------------------------
% hyperlinks:
\newrobustcmd*\CTANurl[2][macros/latex/contrib]{%
  on \ctan\ as \code{#2}: \url{http://mirrors.ctan.org/#1/#2/}%
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
      pdfauthor          = {\forlistloop{}\cnltx@package@author@list},
      pdftitle           =
        {\cnltx@package@name\space\cnltx@package@version\space Manual},
      pdfsubject         = {\cnltx@package@info},
      pdfstartview       = FitH
    }%
}

\endinput
