\NeedsTeXFormat{LaTeX2e}
\newcommand\@classname{delft-hyperloop}
\newcommand\@classversion{2024/12/16}
\ProvidesClass{\@classname}[\@classversion\ Delft Hyperloop Document]
\newcommand\@templatelink{https://www.overleaf.com/read/xkdvnhndtwwg\#fadb5a}

\newcommand\@baseclass{report}
\newcommand\@final{false}
\newcommand\iffinalelse[2]{#2}

\newcommand\@renderusefultemplatestikz{\@renderusefultemplatestikzfromoutput}

\DeclareOption{book}{\renewcommand\@baseclass{book}}
\DeclareOption{report}{\renewcommand\@baseclass{report}}

% \DeclareOption{scrbook}{\renewcommand\@baseclass{scrbook}}
% \DeclareOption{scrreprt}{\renewcommand\@baseclass{scrreprt}}

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

\RequirePackage[a4paper,top=1in,bottom=3cm,left=\@leftmargin,right=\@rightmargin,marginparwidth=\@marginparwidth,footskip=2cm]{geometry}

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
\RequirePackage{transparent}
\RequirePackage{eso-pic}
\RequirePackage[outline]{contour}
\RequirePackage{xparse}
\RequirePackage{setspace}
\RequirePackage{multicol}

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
\newcounter{deptspeople}
\newcommand\definedept[2]{
    \@namedef{@deptname\thealldeptscnt}{#1}
    \@namedef{@deptlead\thealldeptscnt}{#2}
    \edef\df{\@namedef{@deptpeoplestart\thealldeptscnt}{\thedeptspeople}}
    \df
}
\newcommand\deptperson[1]{
    \@namedef{deptspeople\thedeptspeople}{#1}
    \stepcounter{deptspeople}
}
\newcommand\finishdeptdef{
    \edef\df{\@namedef{@deptpeopleend\thealldeptscnt}{\thedeptspeople}}
    \df
    \stepcounter{alldeptscnt}
}
\newcommand\getdeptname[1]{\@nameuse{@deptname#1}}
\newcommand\getdeptlead[1]{\@nameuse{@deptlead#1}}
\newcommand\getdeptpeople[1]{\@makecount{getdeptpeoplecnt}\setcounter{getdeptpeoplecnt}{\number\@nameuse{@deptpeoplestart#1}}\whiledo{\value{getdeptpeoplecnt}<\number\@nameuse{@deptpeopleend#1}}{\ifthenelse{\value{getdeptpeoplecnt}=\@nameuse{@deptpeoplestart#1}}{}{\tptext{, }}\tptext{\@nameuse{deptspeople\thegetdeptpeoplecnt}}\stepcounter{getdeptpeoplecnt}}}

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
    \whiledo{\value{cntdepts}<\value{deptcnt}}{\ifthenelse{\value{cntdepts}=0}{}{\tptext{,} }\tptext{\getdept{\thecntdepts}}\stepcounter{cntdepts}}
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
\newcommand\@authorsfordept[1]{\@makecount{authorsfordeptcnt}\whiledo{\value{authorsfordeptcnt}<\value{alldeptscnt}}{\ifthenelse{\equal{#1}{\getdeptname{\theauthorsfordeptcnt}}}{\tptext{\getdeptlead{\theauthorsfordeptcnt},} \getdeptpeople{\theauthorsfordeptcnt}}{}\stepcounter{authorsfordeptcnt}}}
\newcommand\@defaultauthors{
    \@makecount{defaultauthorscnt}
    \whiledo{\value{defaultauthorscnt}<\value{deptcnt}}{\ifthenelse{\value{defaultauthorscnt}=0}{}{\\}\ifthenelse{\value{deptcnt}>1}{\textcolor{HyperloopGreen}{\tptext{\getdept{\thedefaultauthorscnt}}\tptext{:}} }{}\@authorsfordept{\getdept{\thedefaultauthorscnt}}\stepcounter{defaultauthorscnt}}
}

\newcommand\@titlepageheader{
    % Title and Author at the top
    {\tpboldhuge \@depts \par}
    \vspace{1cm} % Adjust space between title and author
    {\delfthyperlooplogo{0.4}}
}

\newcommand\makeauthors{
    \author{\@defaultauthors}
}

\newcommand\makeauthorsentireteam{
    \renewcommand\@titlepageheader{{\delfthyperlooplogo{0.4}}}
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
    \newcommand\@abstract{}
    \newcommand\abstract[1]{}
}{
    \newcommand\@abstract{}
    \renewcommand\abstract[1]{\renewcommand\@abstract{#1}}
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

\newcommand\@inclwallpaper[1]{
    \AddToShipoutPicture*{
    \put(0,0){%
    \includegraphics[width=\paperwidth,height=\paperheight]{#1}}%
    % \includegraphics[width=\paperwidth,keepaspectratio]{#1}}%
    }
}

\gnewcommand\@titlebody{}

\newcommand\@redesigntitlepage[1]{
    \grenewcommand\@titlebody{#1}
}

\newcommand\designcoverpage[1]{
    \@redesigntitlepage{#1}
}

\ExplSyntaxOn
\NewDocumentCommand{\@tptextimpl}{m}
{
  \seq_set_split:Nnn \l_tmpa_seq { ~ } { #1 }
  \seq_map_inline:Nn \l_tmpa_seq { \contour{tpcontourcolor}{##1} ~ } \unskip
}
\ExplSyntaxOff

\newcommand\tptext[1]{\expandafter\@tptextimpl\expandafter{#1}}
\newcommand\tptexthyperloopgreen[1]{\tptext{\textcolor{HyperloopGreen}{#1}}}

\newcommand\@deftpcommands{
    % \newcommand\@tptextlinewidth{.05ex}
    % \newcommand\tptext[1]{{\color{black}\textpdfrender{
    %     TextRenderingMode=FillStroke,
    %     FillColor=white,
    %     LineWidth=\@tptextlinewidth,
    % }{##1}}}
    
    % \newcommand\tptexthyperloopgreen[1]{{\color{white}\textpdfrender{
    %     TextRenderingMode=FillStroke,
    %     FillColor=HyperloopGreen,
    %     LineWidth=\@tptextlinewidth,
    % }{##1}}}

    % \DeclareRobustCommand{\tptextcontour}[1]{\contour{black}{##1}}
    % \newcommand{\tptext}[1]{%
    %   \@tfor\next:=##1\do{\tptextcontour{\next}}%
    % }

    % \def\@titleex{\@title}
    % \def\@authorex{\@author}
    % \def\@dateex{\@date}
    % % \edef\@doclinkfullex{\@doclinkheader \\ \url{\@doclink}}
    % \def\@tptemplateversionlineex{Template version: \tptexthyperloopgreen{\hyperref[sec:changelog:\@classversion]{\@classversion}} (\tptexthyperloopgreen{\hyperref[sec:how-to-update-template]{update}})}

    \expandafter\newcommand\expandafter\tpdoctitle\expandafter{\@title}
    \expandafter\newcommand\expandafter\tpdocauthorinfo\expandafter{\@author}
    \expandafter\newcommand\expandafter\tpdocdate\expandafter{\@date}
    \expandafter\newcommand\expandafter\tpheader\expandafter{\@titlepageheader}

    \expandafter\newcommand\expandafter\tpdoclinkheader{\@doclinkheader}
    \expandafter\newcommand\expandafter\tpdoclink\expandafter{\@doclink}
    \expandafter\newcommand\expandafter\tpdoclinkfull\expandafter{\@doclinkheader \\ \url{\@doclink}}
    \expandafter\newcommand\expandafter\tplinktomainmatter\expandafter[1]{\hyperref[BeginMainMatter]{##1}}
    \expandafter\newcommand\expandafter\tplinktotemplateinfo\expandafter[1]{\hyperref[BeginTemplateInfo]{##1}}
    \expandafter\newcommand\expandafter\tpconfdisclaimer\expandafter{\@confdisclaimer}
    \expandafter\newcommand\expandafter\tpabstract\expandafter{\@abstract}
    \expandafter\newcommand\expandafter\tptemplateversionline\expandafter{Template version: \tptexthyperloopgreen{\hyperref[sec:changelog:\@classversion]{\@classversion}} (\tptexthyperloopgreen{\hyperref[sec:how-to-update-template]{update}})}
    \newcommand\tpwallpaper[1][rsc/coverwallpaper.jpg]{\@inclwallpaper{##1}}
}

\renewcommand\maketitle{
    % \savegeometry{normal}
    % \newgeometry{layoutwidth=210mm,layoutheight=372mm,left=30mm,right=30mm,bottom=20mm,top=40mm}
    % \savegeometry{Layouttitlepage}

    \begin{titlepage}
        % \pdfpagewidth=210mm \pdfpageheight=372mm % for PDF output
        % \paperwidth=210mm \paperheight=372mm     % for TikZ
        % \loadgeometry{Layouttitlepage}

        \@deftpcommands
        \@titlebody
    \end{titlepage}

    % \loadgeometry{normal}
}

% ===========================================
% =========== Table of contents =============
% ===========================================

\renewcommand\tableofcontents{
    \chapter*{Table of Contents}
    \@starttoc{toc}
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

\newcommand\@usefulsnippetslinks{\@makeusefulsnippetslinkspagefooter}

\newcommand\@onesidedpagestyles{
    \fancypagestyle{ournormal}{
      %... then configure it.
      \fancyhead{} % clear all header fields
      \fancyhead[C]{\textbf{\@title}}
      \fancyfoot{} % clear all footer fields
      \fancyfoot[L]{\ifnotfinal{\@usefulsnippetslinks}}
      \fancyfoot[C]{\@pageidx}
      \renewcommand\footrulewidth{0pt}% Line at the footer visible
    
      \fancyhead[R]{\small \nouppercase{\leftmark\hfill\rightmark}}
    }
    
    \pagestyle{ournormal}
    
    \fancypagestyle{plain}{%
      \fancyhf{}%
      \fancyfoot[C]{\@pageidx}
      \fancyfoot[L]{\ifnotfinal{\@usefulsnippetslinks}}
      \renewcommand\headrulewidth{0pt}% Line at the header invisible
      \renewcommand\footrulewidth{0pt}% Line at the footer visible
    }

    \newcommand\initpagestyles{
        \AddToShipoutPictureBG{
            \AtPageLowerLeft{\includegraphics[width=\paperwidth,keepaspectratio]{rsc/footer.png}}%
        }
    }
}
\newcommand\@twosidedpagestyles{
    \fancypagestyle{ournormal}{
      %... then configure it.
      \fancyhead{} % clear all header fields
      \fancyhead[C]{\textbf{\@title}}
      \fancyfoot{} % clear all footer fields
      \fancyfoot[C]{\@pageidx}
      \fancyfoot[L]{\ifnotfinal{\@usefulsnippetslinks}}
      \renewcommand\footrulewidth{0pt}% Line at the footer visible
    
      \fancyhead[LE]{\small \nouppercase{\rightmark\hfill\leftmark}}
      \fancyhead[RO]{\small \nouppercase{\leftmark\hfill\rightmark}}
    }
    
    \pagestyle{ournormal}
    
    \fancypagestyle{plain}{%
      \fancyhf{}%
      \fancyfoot[C]{\@pageidx}
      \fancyfoot[L]{\ifnotfinal{\@usefulsnippetslinks}}
      \renewcommand\headrulewidth{0pt}% Line at the header invisible
      \renewcommand\footrulewidth{0pt}% Line at the footer visible
    }

    \newcommand\initpagestyles{
        \AddToShipoutPictureBG{
            \AtPageLowerLeft{\includegraphics[width=\paperwidth,keepaspectratio]{rsc/footer.png}}%
        }
    }
}

\ifthenelse{\equal{\@baseclass}{book}}{\@twosidedpagestyles}{
    \ifthenelse{\equal{\@baseclass}{scrbook}}{\@twosidedpagestyles}{
        \ifthenelse{\equal{\@baseclass}{report}}{\@onesidedpagestyles}{
            \ifthenelse{\equal{\@baseclass}{scrreprt}}{\@onesidedpagestyles}{
                \@error{Unrecognized baseclass: "\@baseclass"}
            }
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

\newcommand\tichapter[1]{\chapter*{#1 \markright{#1}}}

\newcommand\@makeusefulsnippetslinkspagefooter{\hyperref[chapter:useful-snippets]{\color{HyperloopGreen} Useful snippets} \@makeusefulsnippetslinkspagefootertikz}
\newcommand\@makeusefulsnippetslinkspagefootertikz{(and \hyperref[chapter:useful-snippets-tikz]{\textbf{\color{HyperloopGreen} TikZ}})}

\newcommand\@includetemplatechangelog{\input{rsc/changelog}}
\newcommand\@includetemplateguidelines{\input{rsc/guidelines}}
\newcommand\@includehowtotemplatechapter{\input{rsc/how-to-template}}
\newcommand\@includeusefultikzsnippets{
    \tichapter{Useful TikZ snippets} \label{chapter:useful-snippets-tikz}
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
}
\newcommand\@includeusefulsnippets{
    \tichapter{Useful snippets} \label{chapter:useful-snippets}
    \addcontentsline{toc-useful-snippets}{chapter}{Useful general \LaTeX\ snippets}
    \@starttoc{toc-useful-snippets}
    \newpage
    
    \@renderusefultemplates

    \@includeusefultikzsnippets
}

\newcommand\skiptemplatechangelog{\renewcommand\@includetemplatechangelog{}}
\newcommand\skiptemplateguidelines{\renewcommand\@includetemplateguidelines{}}
\newcommand\skiphowtotemplatechapter{\renewcommand\@includehowtotemplatechapter{}}
\newcommand\skipusefulsnippets{
    \renewcommand\@includeusefulsnippets{}
    \renewcommand\@makeusefulsnippetslinkspagefooter{}
}
\newcommand\skipusefultikzsnippets{
    \renewcommand\@includeusefultikzsnippets{}
    \renewcommand\@makeusefulsnippetslinkspagefootertikz{}
}

\newcommand\templateinfo{
    \part*{About the \TeX\ \& \LaTeX\ Template
    \\[\bigskipamount] \large \color{blue} You can uncomment the \textit{final,} line at the top of \textit{main.tex} to remove this. \\ \color{red} If this is your first time using the template, please read through this whole part before changing anything. \markboth{About the template}{About the template}}
    \label{BeginTemplateInfo}
    \@includetemplatechangelog
    \@includetemplateguidelines
    \@includehowtotemplatechapter
    \@includeusefulsnippets
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
