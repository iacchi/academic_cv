\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{academic_cv}[2026/06/26 An easy-to-use class to produce stylish CVs for academics]

% The next lines of code handle the options received
% from the tex file: they create a variable for the
% SidebarWidth length, and pass everything else to
% the article class loaded below.

\DeclareKeys[academiccv]{
  SidebarWidth.store = \SidebarWidth,
  SidebarWidth.usage = load
}
\SetKeys[academiccv]{SidebarWidth=8.6cm}
\DeclareUnknownKeyHandler[academiccv]{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessKeyOptions[academiccv]

% -------------------------------------------------
% Base class
% -------------------------------------------------

\LoadClass{article}

% -------------------------------------------------
% Required packages
% -------------------------------------------------

\usepackage[margin=0cm]{geometry} % flowfram controls the layout
\usepackage{libertine}
\usepackage{libertinust1math}
\usepackage[TU]{fontenc}
\usepackage{fontawesome7}
\usepackage{academicons}
\usepackage{twemojis}
\usepackage[hidelinks]{hyperref}
\usepackage{xcolor}
\usepackage{nopageno}
\usepackage{graphicx}
\usepackage{enumitem}
\usepackage{calc}
\usepackage{flowfram}
\usepackage{tikz}
\usepackage{titlesec}
\usepackage{refcount}
\usepackage{tabularx}
\usepackage{setspace}

\setlength\parindent{0pt}
\titlespacing*{\subsection}{0pt}{5pt}{2pt}

% -------------------------------------------------
% Commands to create variables to pass values to
% the class from the main tex file.
% -------------------------------------------------

\newcommand{\Name}[1]{\renewcommand{\Name}{#1}}
\newcommand{\Surname}[1]{\renewcommand{\Surname}{#1}}
\newcommand{\JobDescription}[1]{\renewcommand{\JobDescription}{#1}}
\newcommand{\RightText}[1]{\renewcommand{\RightText}{#1}}
\newcommand{\Picture}[1]{\renewcommand{\Picture}{#1}}
\newcommand{\ContactLangSpacing}[1]{\renewcommand{\ContactLangSpacing}{#1}}
\newcommand{\ConferenceSpacing}[1]{\renewcommand{\ConferenceSpacing}{#1}}
\newcommand{\ContactTitle}[1]{\renewcommand{\ContactTitle}{#1}}
\newcommand{\ContactDetails}[1]{\renewcommand{\ContactDetails}{#1}}
\newcommand{\LanguagesTitle}[1]{\renewcommand{\LanguagesTitle}{#1}}
\newcommand{\LanguagesDetails}[1]{\renewcommand{\LanguagesDetails}{#1}}
\newcommand{\ProfSkillsTitle}[1]{\renewcommand{\ProfSkillsTitle}{#1}}
\newcommand{\ProfSkillsDetails}[1]{\renewcommand{\ProfSkillsDetails}{#1}}
\newcommand{\SoftSkillsTitle}[1]{\renewcommand{\SoftSkillsTitle}{#1}}
\newcommand{\SoftSkillsDetails}[1]{\renewcommand{\SoftSkillsDetails}{#1}}
\newcommand{\DigitalSkillsTitle}[1]{\renewcommand{\DigitalSkillsTitle}{#1}}
\newcommand{\DigitalSkillsDetails}[1]{\renewcommand{\DigitalSkillsDetails}{#1}}
\newcommand{\OtherInterestsTitle}[1]{\renewcommand{\OtherInterestsTitle}{#1}}
\newcommand{\OtherInterestsDetails}[1]{\renewcommand{\OtherInterestsDetails}{#1}}
\newcommand{\ReferencesTitle}[1]{\renewcommand{\ReferencesTitle}{#1}}
\newcommand{\ReferencesDetails}[1]{\renewcommand{\ReferencesDetails}{#1}}

% -------------------------------------------------
% Layout parameters used by flowfram to draw pages
% -------------------------------------------------

\newlength{\Gap}
\newlength{\TopM}
\newlength{\BotM}
\newlength{\LeftM}
\newlength{\RightM}
\newlength{\HeaderH}
\newlength{\FirstHeaderH}
\newlength{\SidebarW}
\newlength{\SidebarH}
\setlength{\Gap}{6mm}
\setlength{\TopM}{6mm}
\setlength{\BotM}{6mm}
\setlength{\LeftM}{6mm}
\setlength{\RightM}{6mm}
\setlength{\HeaderH}{1.2cm}
\setlength{\FirstHeaderH}{2.6cm}
\setlength{\SidebarW}{\SidebarWidth}
\setlength{\SidebarH}{\paperheight-\FirstHeaderH}

% -------------------------------------------------
% Frame definitions to draw pages
% -------------------------------------------------

% Page 1, header
\newdynamicframe[1]
  {\paperwidth}
  {\FirstHeaderH}
  {0cm}
  {\SidebarH}
  [headerfirst]
\setdynamicframe*{headerfirst}{backcolor=HeaderColor}

% Page 1, sidebar
\newdynamicframe[1]
  {\SidebarW}
  {\SidebarH}
  {0cm}
  {0cm}
  [sidebar]
\setdynamicframe*{sidebar}{backcolor=SidebarColor}

% Page 1, main text
\newflowframe[1]
  {\paperwidth-\LeftM-\RightM-\SidebarW}
  {\paperheight-\TopM-\BotM-\FirstHeaderH+2mm}
  {\LeftM+\SidebarW}
  {\BotM}
  [pagefirst]

% Regular page, header
\newdynamicframe[>1]
  {\paperwidth}
  {\HeaderH}
  {0pt}
  {\paperheight-\HeaderH}
  [header]
\setdynamicframe*{header}{backcolor=HeaderColor}

% Regular page, main text
\newflowframe[>1]
  {\paperwidth-\LeftM-\RightM}
  {\paperheight-\BotM-\HeaderH-\TopM+0.2cm}
  {\LeftM}
  {\BotM}
  [page]

% -------------------------------------------------
% Commands to create entries in the main text.
% -------------------------------------------------

% Format of the title section in the side column
% based on https://tex.stackexchange.com/questions/65731
\makeatletter
\def\cv@hrulefill{{\leavevmode\leaders\hrule height 1pt\hfill\kern\z@}}
% line before and after text (some tweaking is required here)
% based on https://tex.stackexchange.com/questions/15119
\NewDocumentCommand{\ruleline}{m}{\par\noindent\raisebox{\baselineskip/4}{\makebox[\linewidth]{\cv@hrulefill\hspace{1ex}\raisebox{-\baselineskip/4}{\large #1}\hspace{1ex}\cv@hrulefill}}\vspace*{0.05cm}}
\makeatother

% Entry for contacts and languages sections
\newcommand{\contactlangentry}[2]{
  \hspace{-2.2mm}
  \begin{minipage}{7mm}\centering
    #1
  \end{minipage}
  \begin{minipage}{\SidebarW-\Gap-\LeftM-7mm+2.2mm}\raggedright
    #2
  \end{minipage}
  \vskip \ContactLangSpacing
}

% Wrapper for skill tags
\newcommand{\skilltag}[1]{
  \tikz[baseline]\node[anchor=base,draw=black!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{#1};
}

% Wrapper for other interests
\newcommand{\myinterest}[1]{\mbox{#1}}

% Format of the section titles
\titleformat{\section}{\bf\Large\raggedright}{}{0em}{}[\titlerule]
\titlespacing{\section}{0pt}{12pt}{5pt} % Spacing around titles {<left spacing>}{<before spacing>}{<after spacing>}

% Create new length for \EduWorkEntry minipage
\newlength{\EduWorkMinipage}
\newlength{\EduWorkSmallMinipage}
\setlength{\EduWorkSmallMinipage}{2.2cm}
% The five inputs are: years, title, university,
% city, description
\newcommand{\EduWorkEntry}[5]{
  % Check if I'm in page 1 to set different
  % minipage lengths
  \if\thepage1
    \setlength{\EduWorkMinipage}{\paperwidth-\SidebarW-\Gap-\RightM-\EduWorkSmallMinipage-\LeftM}
  \else
    \setlength{\EduWorkMinipage}{\paperwidth-\Gap-\RightM-\EduWorkSmallMinipage-\LeftM}
  \fi
  \begin{minipage}[t]{\EduWorkSmallMinipage}
    \begin{center}
      \textbf{#1}
    \end{center}
  \end{minipage}
  \hspace{1mm} \vline \hspace{1.5mm}
  \begin{minipage}[t]{\EduWorkMinipage}
    {\large\textbf{#2}}
    \hfill {\faLocationDot ~ #3}
    \newline
    {\large\emph{#4}} \\
    {#5} 
  \end{minipage}
  \vskip 2.5mm
}

% The eight inputs are: year, authors, title, 
% journal, volume, pages, DOI, other info
\newcommand{\publication}[8]{
  \raggedright #2, % authors
  \expandafter\ifx\expandafter\relax\detokenize{#3}\relax\else{``#3'', }\fi % title if present
  \textit{#4} % journal
  \textbf{#1}, % year
  \expandafter\ifx\expandafter\relax\detokenize{#5}\relax\else{\textit{#5}, }\fi % volume if present
  #6. % pages
  \expandafter\ifx\expandafter\relax\detokenize{#7}\relax\else{\mbox{\aiDoi{}  \href{https://www.doi.org/#7}{#7}} }\fi % DOI if present
  \mbox{\aiImpactstory{} #8}. % other info
}

\newcommand{\Conferences}[1]{
  \bgroup
    \def\arraystretch{\ConferenceSpacing}
    \begin{tabularx}{\linewidth}{@{}lX@{}}
      #1 
    \end{tabularx}
  \egroup
}

% -------------------------------------------------
% Header content
% -------------------------------------------------

\begin{dynamiccontents*}{headerfirst}
  \parbox[t][\FirstHeaderH][t]{\paperwidth}{
    \vfill % center vertically
    \centering % center horizontally
    {\huge \color{HeaderTextColor} \Name{} \textbf{\Surname}} \par 
    \vspace{0.2cm}
    \color{HeaderTextColor} \large \JobDescription{}
    \vfill % center vertically
  }
\end{dynamiccontents*}

\begin{dynamiccontents*}{header}
  \parbox[t][\HeaderH][t]{\paperwidth}{
    \vfill % center vertically
    \hspace{\LeftM}
    \large \color{HeaderTextColor} \Name{} \textbf{\Surname}
    \hfill
    \large \color{HeaderTextColor} \RightText{}
    \hspace{\RightM}
    \vfill % center vertically
  }
\end{dynamiccontents*}

% -------------------------------------------------
% Sidebar content
% -------------------------------------------------

\begin{dynamiccontents*}{sidebar}
  \vspace{\TopM-2mm}
  \hspace{\LeftM-2mm}
  \begin{minipage}{\SidebarW-\Gap-\LeftM+2mm}
    % Profile picture if exists
    \ifdefempty{\Picture}{}{
      \begin{center}
  \includegraphics[height=4cm]{\Picture}
      \end{center}
    \vspace{-3mm}
    }
    % Contacts section
    \ruleline{\textbf{\ContactTitle}}
    \vskip 1mm
    \ContactDetails{}
    \vspace{2mm-\ContactLangSpacing}
    % Languages section
    \ruleline{\textbf{\LanguagesTitle}}
    \vskip 1mm
    \LanguagesDetails{}
    \vspace{2mm-\ContactLangSpacing}
    % Professional skills section
    \ruleline{\textbf{\ProfSkillsTitle}}
    \vskip -0.5mm
    {\setstretch{1.45} \centering \ProfSkillsDetails{} \par}
    \vskip 3mm
    % Soft skills section
    \ruleline{\textbf{\SoftSkillsTitle}}
    \vskip -0.5mm
    {\setstretch{1.45} \centering \SoftSkillsDetails{} \par}
    \vskip 3mm
    % Digital skills section
    \ruleline{\textbf{\DigitalSkillsTitle}}
    \vskip -0.5mm
    {\setstretch{1.45} \centering \DigitalSkillsDetails{} \par}
    \vskip 3mm
    % Other interests section
    \ruleline{\textbf{\OtherInterestsTitle}}
    \vskip 1mm
    {\setstretch{1.2} \parfillskip 0pt \OtherInterestsDetails \par}
    \vskip 2mm
    % References section
    \ruleline{\textbf{\ReferencesTitle}}
    \vskip 2mm
    \ReferencesDetails{}
  \end{minipage}
\end{dynamiccontents*}