\NeedsTeXFormat{LaTeX2e}
\newcommand\@classversion{2024/11/18}
\ProvidesClass{delft-hyperloop}[\@classversion\ Delft Hyperloop Document]
\newcommand\@templatelink{https://www.overleaf.com/read/xkdvnhndtwwg\#fadb5a}

\newcommand\@baseclass{article}
\newcommand\@final{false}
\newcommand\iffinalelse[2]{#2}


\DeclareOption{book}{\renewcommand\@baseclass{book}}
\DeclareOption{report}{\renewcommand\@baseclass{report}}
\DeclareOption{article}{\renewcommand\@baseclass{article}}
\DeclareOption{final}{
    \renewcommand\@final{true}
    \renewcommand\iffinalelse[2]{#1}
}

\ProcessOptions\relax

% ======================================
% =========== Core commands ============
% ======================================
\def\gnewcommand{\g@star@or@long\new@command}
\def\grenewcommand{\g@star@or@long\renew@command}
\def\g@star@or@long#1{% 
  \@ifstar{\let\l@ngrel@x\global#1}{\def\l@ngrel@x{\long\global}#1}}

\newcommand\@error[1]{\expandafter\ClassError{delft-hyperloop}{#1}{Ask Dinu for help.}}

\LoadClass{\@baseclass}

\RequirePackage{ifthen}

% Todo notes want some very big page margins, so if final, use 1.75cm, else use 2.5cm to have enough space
\ifthenelse{\equal{\@final}{true}}{
    \newcommand\@marginparwidth{1.75cm}
}{
    \newcommand\@marginparwidth{2.5cm}
}

\RequirePackage[a4paper,top=1in,bottom=1in,left=1.25in,right=1.25in,marginparwidth=\@marginparwidth]{geometry}


\RequirePackage[english]{babel}
\RequirePackage{array}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{wrapfig}
\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage{sectsty}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{xargs}
\RequirePackage[toc,page]{appendix}
\RequirePackage{trace}
\RequirePackage{trimspaces}
\RequirePackage{enumitem}
\RequirePackage{booktabs}
\RequirePackage{comment}
\RequirePackage[normalem]{ulem}
\RequirePackage{amsmath}
\RequirePackage{hhline}
\RequirePackage{subcaption}
\RequirePackage{makeidx}
\RequirePackage{csquotes}
\RequirePackage[style=ieee,sorting=ynt]{biblatex}
\RequirePackage{environ}
\RequirePackage[colorlinks=true, linkcolor=, citecolor=, urlcolor=HyperloopGreen]{hyperref}
\RequirePackage{lipsum}
\RequirePackage[skip=10pt plus1pt, indent=0pt]{parskip}
\RequirePackage[record,acronym,toc,hyperfirst]{glossaries-extra}
\RequirePackage[colorinlistoftodos,prependcaption,textsize=tiny]{todonotes}
\RequirePackage[left, pagewise]{lineno}

\makeindex

\definecolor{HyperloopGreen}{HTML}{017357}
\definecolor{customgreen}{HTML}{2EAB7B}
\chapterfont{\color{HyperloopGreen}}

% \sectionfont{\color{HyperloopGreen}}

% ===========================================
% ====== Team information ===================
% ===========================================

\newcommand\@company{Delft Hyperloop}
\newcommand\@generation{9}
\newcommand\@generationroman{IX}
\newcommand\@companyandgen{\@company\ \@generationroman}

% ========================
% ==== Departments =======
% ========================
\newcounter{deptcnt}
\newcommand\adddept[1]{
    \@namedef{@dept\thedeptcnt}{#1}
    \stepcounter{deptcnt}
}
\newcommand\getdept[1]{\@nameuse{@dept#1}}

\newcounter{alldeptscnt}
\newcommand\definedept[3]{
    \@namedef{@deptname\thealldeptscnt}{#1}
    \@namedef{@deptlead\thealldeptscnt}{#2}
    \@namedef{@deptpeople\thealldeptscnt}{#3}
    \stepcounter{alldeptscnt}
}
\newcommand\getdeptname[1]{\@nameuse{@deptname#1}}
\newcommand\getdeptlead[1]{\@nameuse{@deptlead#1}}
\newcommand\getdeptpeople[1]{\@nameuse{@deptpeople#1}}

\newcommand*\ifcounter[1]{%
  \ifcsname c@#1\endcsname
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
}

\newcommand\@makecount[1]{\ifcounter{#1}{\setcounter{#1}{0}}{\newcounter{#1}}}

\newcommand\dept[1]{\adddept{#1}}
\newcommand\@depts{
    \@makecount{cntdepts}
    \whiledo{\value{cntdepts}<\value{deptcnt}}{\ifthenelse{\value{cntdepts}=0}{}{, }\getdept{\thecntdepts}\stepcounter{cntdepts}}
}

% ==========================
% ======= Authors ==========
% ==========================

% Any spaces on the following lines f*ck up the formatting, so do not format this any other way.
\newcommand\@authorsfordept[1]{\@makecount{authorsfordeptcnt}\whiledo{\value{authorsfordeptcnt}<\value{alldeptscnt}}{\ifthenelse{\equal{#1}{\getdeptname{\theauthorsfordeptcnt}}}{\getdeptlead{\theauthorsfordeptcnt}, \getdeptpeople{\theauthorsfordeptcnt}}{}\stepcounter{authorsfordeptcnt}}}
\newcommand\@defaultauthors{
    \@makecount{defaultauthorscnt}
    \whiledo{\value{defaultauthorscnt}<\value{deptcnt}}{\ifthenelse{\value{defaultauthorscnt}=0}{}{\\}\ifthenelse{\value{deptcnt}>1}{\textcolor{HyperloopGreen}{\getdept{\thedefaultauthorscnt}}: }{}\@authorsfordept{\getdept{\thedefaultauthorscnt}}\stepcounter{defaultauthorscnt}}
}
\newcommand\makeauthors{\author{\@defaultauthors}}

% ========================
% ===== Confidential =====
% ========================
\newcommand\confpurpose[1]{\renewcommand\@confpurpose{#1}}
\newcommand\@confpurpose{}

\newcommand\@confdisclaimer{
    \ifdefstring{\@confpurpose}{}{}{
        THIS DOCUMENT AND THE INFORMATION IN IT ARE PROVIDED IN CONFIDENCE, FOR THE SOLE PURPOSE OF \MakeUppercase{\@confpurpose}, AND MAY NOT BE DISCLOSED TO ANY THIRD PARTY OR USED FOR ANY OTHER PURPOSE WITHOUT THE EXPRESS WRITTEN PERMISSION OF \MakeUppercase{\@company}.
    }
}

% ========================
% ======= Abstract =======
% ========================
\newcommand\@abstract{}
\renewcommand\abstract[1]{\renewcommand\@abstract{#1}}
\newcommand\@makeabstract{\ifdefempty{\@abstract}{}{\textbf{Abstract:} \@abstract}}

% =====================================
% ========== Link to project ==========
% =====================================
\newcommand\@doclinkheader{Link to Overleaf Template (most updated version):}
\newcommand\@doclink{\@templatelink}
\newcommand\doclink[2][Link to Overleaf Project (most updated version):]{\renewcommand\@doclinkheader{#1}\renewcommand\@doclink{#2}}

% ===============================
% ====== Title page =============
% ===============================

\renewcommand\maketitle{
    \begin{titlepage}
        \centering
        % Title and Author at the top
        {\Huge \textbf{\@depts} \par}
        \vspace{1cm} % Adjust space between title and author
        {\large \@companyandgen \par}
    
        \vspace{0.5cm} % Adjust space between author and green lines
    
        % First green line
        \textcolor{HyperloopGreen}{\rule{\textwidth}{1.5pt}}
    
        \vspace{0.5cm} % Space between line and title
        % Main title in the center
        {\LARGE \textbf{\@title} \par}
    
        \vspace{0.5cm} % Space between title and second green line
        % Second green line
        \textcolor{HyperloopGreen}{\rule{\textwidth}{1.5pt}}

        {\large \@author \par}
    
        \vspace{1.2cm}
        {\large \@date \par}
        \vspace{0.3cm}
        \ifnotfinal{
            \noindent\fbox{%
                \parbox{\textwidth}{
                    \centering
                    {\@doclinkheader \\ {\color{HyperloopGreen}\url{\@doclink}}}

                    \vspace{0.3cm}
            
                    \hyperref[BeginMainMatter]{Jump to {\color{HyperloopGreen} Main matter}}
                }
            }
        }

    
        \vfill
        % Logo at the bottom
        \delfthyperloop{0.4} % Adjust the width as needed
        \vfill
        
        \@confdisclaimer

        \@makeabstract

        \vfill
        \ifnotfinal{Template version: {\color{HyperloopGreen} \hyperref[sec:changelog:\@classversion]{\@classversion}}}
    \end{titlepage}
}

% ==========================
% ===== Page style =========
% ==========================

\newcommand\@pageidxfrontmatter{F:\thepage\ of F:\pageref{LastPageFrontmatter}}
\newcommand\@pageidxmainmatter{\thepage\ of \pageref{LastPageMainmatter}}
\newcommand\@pageidxbackmatter{B:\thepage\ of B:\pageref{LastPage}}

\newcommand\@pageidx{
    \ifdefstring{\@docpart}{frontmatter}{
        \@pageidxfrontmatter
    }{
    \ifdefstring{\@docpart}{mainmatter}{
        \@pageidxmainmatter
    }{
    \ifdefstring{\@docpart}{backmatter}{
        \@pageidxbackmatter
    }{
    \@error{Unrecognized docpart: "\@docpart"}
    }}}
}

\newcommand\@onesidedpagestyles{
    \fancypagestyle{ournormal}{
      %... then configure it.
      \fancyhead{} % clear all header fields
      \fancyhead[C]{\textbf{\@title}}
      \fancyfoot{} % clear all footer fields
      \fancyfoot[R]{\@pageidx}
      \fancyfoot[C]{\@companyandgen}
      \renewcommand\footrulewidth{0.4pt}% Line at the footer visible
    
      \fancyhead[R]{\nouppercase{\leftmark\hfill\rightmark}}
    }
    
    \pagestyle{ournormal}
    
    \fancypagestyle{plain}{%
      \fancyhf{}%
      \fancyfoot[R]{\@pageidx}
      \fancyfoot[C]{\@companyandgen}
      \renewcommand\headrulewidth{0pt}% Line at the header invisible
      \renewcommand\footrulewidth{0.4pt}% Line at the footer visible
    }
}
\newcommand\@twosidedpagestyles{
    \fancypagestyle{ournormal}{
      %... then configure it.
      \fancyhead{} % clear all header fields
      \fancyhead[RO,LE]{\textbf{\@title}}
      \fancyfoot{} % clear all footer fields
      \fancyfoot[LE,RO]{\@pageidx}
      \fancyfoot[C]{\@companyandgen}
      \renewcommand\footrulewidth{0.4pt}% Line at the footer visible
    
      \fancyhead[LE]{\nouppercase{\rightmark\hfill\leftmark}}
      \fancyhead[RO]{\nouppercase{\leftmark\hfill\rightmark}}
    }
    
    \pagestyle{ournormal}
    
    \fancypagestyle{plain}{%
      \fancyhf{}%
      \fancyfoot[LE,RO]{\@pageidx}
      \fancyfoot[C]{\@companyandgen}
      \renewcommand\headrulewidth{0pt}% Line at the header invisible
      \renewcommand\footrulewidth{0.4pt}% Line at the footer visible
    }
}

\ifthenelse{\equal{\@baseclass}{book}}{\@twosidedpagestyles}{
    \ifthenelse{\equal{\@baseclass}{report}}{\@onesidedpagestyles}{
        \ifthenelse{\equal{\@baseclass}{article}}{\@onesidedpagestyles}{
            \ClassError{delft-hyperloop}{Unrecognized baseclass: "\@baseclass"}{Ask Dinu for help.}
        }
    }
}

% ==========================
% ===== Tables =============
% ==========================


\newcommand\PreserveBackslash[1]{\let\temp=\\#1\let\\=\temp}
\newcolumntype{C}[1]{>{\PreserveBackslash\centering}p{#1}}
\newcolumntype{R}[1]{>{\PreserveBackslash\raggedleft}p{#1}}
\newcolumntype{L}[1]{>{\PreserveBackslash\raggedright}p{#1}}



% ==========================
% ===== Todo's =============
% ==========================

\newcommandx\unsure[2][1=]{\ifnotfinal{\todo[linecolor=red,backgroundcolor=red!25,bordercolor=red,#1]{#2}}}
\newcommandx\change[2][1=]{\ifnotfinal{\todo[linecolor=blue,backgroundcolor=blue!25,bordercolor=blue,#1]{#2}}}
\newcommandx\info[2][1=]{\ifnotfinal{\todo[linecolor=OliveGreen,backgroundcolor=OliveGreen!25,bordercolor=OliveGreen,#1]{#2}}}
\newcommandx\improvement[2][1=]{\ifnotfinal{\todo[linecolor=Plum,backgroundcolor=Plum!25,bordercolor=Plum,#1]{#2}}}
\newcommandx\thiswillnotshow[2][1=]{\ifnotfinal{\todo[disable,#1]{#2}}}

\newcommand\appendixtodolistchapter{\ifnotfinal{\listoftodos[\chapter{List of TODOs}]}}

% ================================
% ======= The FINAL toggle =======
% ================================

\newcommand\iffinal[1]{\iffinalelse{#1}{}}
\newcommand\ifnotfinal[1]{\iffinalelse{}{#1}}

% ====================================
% ======= Various other utils ========
% ====================================

\newcommand*\trim[1]{%
  \trim@spaces@noexp{#1}%
}

\newcommand\dolinenumbers{
    \ifnotfinal{
        \patchcmd{\@startsection}{\@ifstar}{\nolinenumbers\@ifstar}{}{}
        \patchcmd{\@xsect}{\ignorespaces}{\linenumbers\ignorespaces}{}{}
    
        \linenumbers
    }
}

% =================================
% ======= Document parts ==========
% =================================

\gnewcommand\@docpart{}
\gnewcommand\@mainmatterdefined{}
\newbool{@mainmatterdefined}

\newcommand\@beginfrontmattercommons{
    \pagenumbering{roman}
    \grenewcommand\@docpart{frontmatter}
}
\newcommand\@beginmainmattercommons{
    \dolinenumbers
    \pagenumbering{arabic}
    \grenewcommand\@docpart{mainmatter}

    \phantomsection \label{BeginMainMatter}
}
\newcommand\@beginbackmattercommons{
    \grenewcommand\@docpart{backmatter}
    \pagenumbering{arabic}
}

\newcommand\@endfrontmattercommons{
    \phantomsection \label{LastPageFrontmatter}
    \newpage
}

\newcommand\@endmainmattercommons{
    \phantomsection \label{LastPageMainmatter}
    \newpage
}

\ifthenelse{\equal{\@baseclass}{book}}{
    \newcommand\@beginfrontmatter{
        \frontmatter
        \@beginfrontmattercommons
    }

    \newcommand\@endfrontmatter{
        \@endfrontmattercommons
    }
    
    \newcommand\@beginmainmatter{
        \mainmatter
        \@beginmainmattercommons
    }

    \newcommand\@endmainmatter{
        \@endmainmattercommons
    }
    
    \newcommand\@beginbackmatter{
        \backmatter

        \@beginbackmattercommons
    }
}{
    \newcommand\@beginfrontmatter{
        \@beginfrontmattercommons
    }

    \newcommand\@endfrontmatter{
        \@endfrontmattercommons
    }
    
    \newcommand\@beginmainmatter{
        \@beginmainmattercommons
    }

    \newcommand\@endmainmatter{
        \@endmainmattercommons
    }

    \newcommand\@beginbackmatter{
        \@beginbackmattercommons
    }
}

\newenvironment{frontmatter}{
    \@beginfrontmatter
}{
    \@endfrontmatter
}

\newenvironment{mainmatter}{
    \@beginmainmatter
}{
    \@endmainmatter
}

\newenvironment{backmatter}{
    \@beginbackmatter
}{}

\newcommand\delfthyperloop[1]{
    \includegraphics[width=#1\textwidth]{rsc/hyperloop logo.png}
}

\input{rsc/depts/management}
\input{rsc/depts/business}
\input{rsc/depts/scalability}
\input{rsc/depts/mechanical}
\input{rsc/depts/levitation}
\input{rsc/depts/propulsion}
\input{rsc/depts/powertrain}
\input{rsc/depts/sensecon}
\input{rsc/depts/thermal}


% =====================
% ==== Glossaries =====
% =====================
% \GlsXtrRecordCounter{chapter}

% \newcommand{\printchapterglossary}[1][]{%
%   \printunsrtglossary*[nonumberlist,#1]{%
%     \renewcommand{\printunsrtglossaryhandler}[1]{%
%      \glsxtrfieldxifinlist{##1}{record.chapter}{\thechapter}
%      {\glsxtrunsrtdo{##1}}%
%      {}%
%     }%
%   }%
% }

\newcommand\addgloss[2]{\newglossaryentry{#1}{name=#1,description={#2}}}
\newcommand\addglossmath[3]{\newglossaryentry{#3}{name=\ensuremath{#1},description={#2}}}





% =================================
% ====== Template guidelines ======
% =================================
\newcommand\templateguidelines{
    \part*{\TeX\ \& \LaTeX\ Template Guidelines}
    \input{rsc/changelog}
    \input{rsc/guidelines}
    \input{rsc/how-to-template}
    \vfill
    \begin{center}
    \fontsize{1000}{20}\selectfont \textbf{Finalize the document to remove this.}
    \change{Finalize and uncomment the \textit{final,} line at the top of \textit{main.tex}.}
    \end{center}
}