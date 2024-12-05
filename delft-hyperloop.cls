\NeedsTeXFormat{LaTeX2e}
\newcommand\@classname{delft-hyperloop}
\newcommand\@classversion{2024/12/05}
\ProvidesClass{\@classname}[\@classversion\ Delft Hyperloop Document]
\newcommand\@templatelink{https://www.overleaf.com/read/xkdvnhndtwwg\#fadb5a}

\newcommand\@baseclass{report}
\newcommand\@final{false}
\newcommand\iffinalelse[2]{#2}

\newcommand\@renderusefultemplatestikz{\@renderusefultemplatestikzfromoutput}

\DeclareOption{book}{\renewcommand\@baseclass{book}}
\DeclareOption{report}{\renewcommand\@baseclass{report}}
\DeclareOption{final}{
    \renewcommand\@final{true}
    \renewcommand\iffinalelse[2]{#1}
}
\DeclareOption{tikzusefultemplatesrender}{
    \renewcommand\@renderusefultemplatestikz{\@dorenderusefultemplatestikz}
}

\ProcessOptions\relax

% ======================================
% =========== Core commands ============
% ======================================
\def\gnewcommand{\g@star@or@long\new@command}
\def\grenewcommand{\g@star@or@long\renew@command}
\def\g@star@or@long#1{% 
  \@ifstar{\let\l@ngrel@x\global#1}{\def\l@ngrel@x{\long\global}#1}}

\newcommand\@error[1]{\expandafter\ClassError{\@classname}{#1}{Ask Dinu for help.}}

\LoadClass{\@baseclass}

% ===============================
% ========= Packages ============
% ===============================

\RequirePackage{ifthen}

% Todo notes want some very big page margins, so if final, use 1.75cm, else use 2.5cm to have enough space
\iffinalelse{
    \newcommand\@marginparwidth{0.75in}
    \newcommand\@leftmargin{1in}
    \newcommand\@rightmargin{1in}
}{
    \newcommand\@marginparwidth{2.5cm}
    \newcommand\@leftmargin{1.25in}
    \newcommand\@rightmargin{1.25in}
}

\RequirePackage[a4paper,top=1in,bottom=1in,left=\@leftmargin,right=\@rightmargin,marginparwidth=\@marginparwidth]{geometry}

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
\RequirePackage{minted}
\RequirePackage{fancyvrb}

% TikZ
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,decorations.pathmorphing,backgrounds,positioning,fit,petri,intersections}
% \usetikzlibrary{external}

% Pgfplots
\RequirePackage{pgfplots}

% \usepgfplotslibrary{external}
% \tikzexternalize

\makeindex

% ===========================
% ======== Colors ===========
% ===========================

\definecolor{HyperloopGreen}{HTML}{017357}
\definecolor{customgreen}{HTML}{2EAB7B}
\definecolor{bloodred}{HTML}{EE4B2B}

\chapterfont{\color{HyperloopGreen}}
% \sectionfont{\color{HyperloopGreen}}

% ============================================
% =========== Team information ===============
% ============================================

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

\input{rsc/depts/management}
\input{rsc/depts/business}
\input{rsc/depts/scalability}
\input{rsc/depts/mechanical}
\input{rsc/depts/levitation}
\input{rsc/depts/propulsion}
\input{rsc/depts/powertrain}
\input{rsc/depts/sensecon}
\input{rsc/depts/thermal}

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

\newcommand\@titlepageheader{
    % Title and Author at the top
    {\Huge \textbf{\@depts} \par}
    \vspace{1cm} % Adjust space between title and author
    {\large \@companyandgen \par}
}

\newcommand\makeauthorsentireteam{
    \renewcommand\@titlepageheader{{\Huge \textbf{\@companyandgen} \par}}
}

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

\ifthenelse{\equal{\@baseclass}{book}}{
    \newcommand\@makeabstract{}
    \newcommand\abstract[1]{}
}{
    \newcommand\@abstract{}
    \renewcommand\abstract[1]{\renewcommand\@abstract{#1}}
    \newcommand\@makeabstract{\ifdefempty{\@abstract}{}{\textbf{Abstract:} \@abstract}}
}

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
        \@titlepageheader
    
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
        \delfthyperlooplogo{0.4} % Adjust the width as needed
        \vfill
        
        \@confdisclaimer

        \@makeabstract

        \vfill
        \ifnotfinal{Template version: {\color{HyperloopGreen} \hyperref[sec:changelog:\@classversion]{\@classversion}} (\textbf{\color{HyperloopGreen} \hyperref[sec:how-to-update-template]{update}})}
    \end{titlepage}
}

% ==========================
% ===== Page style =========
% ==========================

\newcommand\@pageidxfrontmatter{\thepage\ of \pageref{LastPageFrontmatter}}
\newcommand\@pageidxmainmatter{\thepage\ of \pageref{LastPageMainmatter}}
\newcommand\@pageidxbackmatter{\thepage\ of \pageref{LastPage}}

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

\newcommand\@usefulsnippetslinks{\hyperref[chapter:useful-snippets]{\color{HyperloopGreen} Useful snippets} (and \hyperref[chapter:useful-snippets-tikz]{\textbf{\color{HyperloopGreen} TikZ}})}

\newcommand\@onesidedpagestyles{
    \fancypagestyle{ournormal}{
      %... then configure it.
      \fancyhead{} % clear all header fields
      \fancyhead[C]{\textbf{\@title}}
      \fancyfoot{} % clear all footer fields
      \fancyfoot[L]{\ifnotfinal{\@usefulsnippetslinks}}
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
      \fancyfoot[L]{\ifnotfinal{\@usefulsnippetslinks}}
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
      \fancyfoot[LO,RE]{\ifnotfinal{\@usefulsnippetslinks}}
      \renewcommand\footrulewidth{0.4pt}% Line at the footer visible
    
      \fancyhead[LE]{\nouppercase{\rightmark\hfill\leftmark}}
      \fancyhead[RO]{\nouppercase{\leftmark\hfill\rightmark}}
    }
    
    \pagestyle{ournormal}
    
    \fancypagestyle{plain}{%
      \fancyhf{}%
      \fancyfoot[LE,RO]{\@pageidx}
      \fancyfoot[C]{\@companyandgen}
      \fancyfoot[LO,RE]{\ifnotfinal{\@usefulsnippetslinks}}
      \renewcommand\headrulewidth{0pt}% Line at the header invisible
      \renewcommand\footrulewidth{0.4pt}% Line at the footer visible
    }
}

\ifthenelse{\equal{\@baseclass}{book}}{\@twosidedpagestyles}{
    \ifthenelse{\equal{\@baseclass}{report}}{\@onesidedpagestyles}{
        \@error{Unrecognized baseclass: "\@baseclass"}
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

% ==============================================
% ======= Commands with the final toggle =======
% ==============================================

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

\newcommand\delfthyperlooplogo[1]{
    \includegraphics[width=#1\textwidth]{rsc/hyperloop logo.png}
}

% =================================
% ======= Document parts ==========
% =================================

\gnewcommand\@docpart{}

\newcommand\@beginfrontmattercommons{
    \setcounter{page}{1}
    \grenewcommand{\thepage}{F:\roman{page}}
    \grenewcommand\@docpart{frontmatter}
}
\newcommand\@beginmainmattercommons{
    \dolinenumbers
    \setcounter{page}{1}
    \grenewcommand{\thepage}{\arabic{page}}
    \grenewcommand\@docpart{mainmatter}

    \phantomsection \label{BeginMainMatter}
}
\newcommand\@beginbackmattercommons{
    \grenewcommand\@docpart{backmatter}
    \setcounter{page}{1}
    \grenewcommand{\thepage}{B:\arabic{page}}
}

\newcommand\@endfrontmattercommons{
    \phantomsection \label{LastPageFrontmatter}
    \newpage
}

\newcommand\@endmainmattercommons{
    \phantomsection \label{LastPageMainmatter}
    \newpage
}
\newcommand\@endbackmattercommons{
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

    \newcommand\@endbackmatter{
        \@endbackmattercommons
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

    \newcommand\@endbackmatter{
        \@endbackmattercommons
    }
}

\newenvironment{clsfrontmatter}{
    \@beginfrontmatter
}{
    \@endfrontmatter
}

\newenvironment{clsmainmatter}{
    \@beginmainmatter
}{
    \@endmainmatter
}

\newenvironment{clsbackmatter}{
    \@beginbackmatter
}{
    \@endbackmatter
}

% =====================
% ==== Glossaries =====
% =====================
\newcommand\addgloss[2]{\newglossaryentry{#1}{name=#1,description={#2}}}
\newcommand\addglossmath[3]{\newglossaryentry{#3}{name=\ensuremath{#1},description={#2}}}





% =================================
% ====== Template guidelines ======
% =================================
\newcommand\templateguidelines{
    \part*{About the \TeX\ \& \LaTeX\ Template
    \\[\bigskipamount] \large \color{blue} You can uncomment the \textit{final,} line at the top of \textit{main.tex} to remove this. \\ \color{red} If this is your first time using the template, please read through this whole part before changing anything.}
    \input{rsc/changelog}
    \input{rsc/guidelines}
    \input{rsc/how-to-template}

    \chapter*{Useful snippets} \label{chapter:useful-snippets}
    \addcontentsline{toc-useful-snippets}{chapter}{Useful general \LaTeX\ snippets}
    \@starttoc{toc-useful-snippets}
    \newpage
    
    \@renderusefultemplates

    \chapter*{Useful TikZ snippets} \label{chapter:useful-snippets-tikz}
    \addcontentsline{toc-useful-snippets}{chapter}{Useful TikZ snippets}
    % \addcontentsline{toc-useful-snippets-tikz}{chapter}{Useful TikZ snippets}

    \@starttoc{toc-useful-snippets-tikz}
    
    \section*{Introduction}
    \addcontentsline{toc-useful-snippets-tikz}{section}{Introduction}

    Here you can find useful TikZ / Pgfplots snippets. TikZ is a \LaTeX\ package that can create graphical elements from \LaTeX\ code, and Pgfplots is a \LaTeX\ package based on TikZ that can automatically render plots from formulas alone. These snippets come from Overleaf's documentation on TikZ and Pgfplots. For explanations on what the options to those commands do, refer to those resources:

    \textbf{For TikZ}:
    \begin{itemize}
        \item \url{https://www.overleaf.com/learn/latex/TikZ_package}
        \item \url{https://cremeronline.com/LaTeX/minimaltikz.pdf} for a small introduction to TikZ.
        \item \url{https://mirror.koddos.net/CTAN/graphics/pgf/base/doc/pgfmanual.pdf} for the in-depth manual on how to use TikZ / pgf.
        \item \url{https://ctan.org/pkg/tikz?lang=en} for the CTAN page of tikz.
    \end{itemize}

    \textbf{For Pgfplots}:
    \begin{itemize}
        \item \url{https://www.overleaf.com/learn/latex/Pgfplots_package}
        \item \url{https://ftp.snt.utwente.nl/pub/software/tex/graphics/pgf/contrib/pgfplots/doc/pgfplots.pdf} for the in-depth manual on how to use Pgfplots.
        \item \url{https://ctan.org/pkg/pgfplots?lang=en} for the CTAN page of pgfplots.
    \end{itemize}

    \newpage
    
    \@renderusefultemplatestikz
    \vfill
    \begin{center}
    \fontsize{1000}{20}\selectfont \textbf{Finalize the document to remove this.}
    \change{Finalize and uncomment the \textit{final,} line at the top of \textit{main.tex}.}
    \end{center}
}

\newcommand\@codeandoutput[3]{%
    \begin{listing}[!ht]
        \inputminted{tex}{#1.tex}
        \caption{#3}
        \label{listing:#2}
    \end{listing}

    \input{#1}
}

\newcommand\@codeandoutputtikzrender[4]{
    \begin{listing}[!ht]
        \inputminted{tex}{#1.tex}
        \caption{#3}
        \label{listing:#2}
    \end{listing}

    % \begin{figure}[tph!]
    %     \centering
        \input{#1}
    %     \caption{#4}
    %     \label{fig:#2}
    % \end{figure}
}

\newcommand\@codeandoutputtikz[5]{%
    \def\tikzpage{\the\numexpr#5+1\relax}
    \begin{listing}[!ht]
        \inputminted{tex}{#1.tex}
        \caption{#3}
        \label{listing:#2}
    \end{listing}

    % \begin{figure}[tph]
    % \centering
    \includegraphics[page=\tikzpage, clip]{rsc/useful-templates-tikz.pdf}
    %     \caption{#4}
    %     \label{fig:#2}
    % \end{figure}
}

\input{rsc/useful-templates}
\input{rsc/useful-templates-tikz}
