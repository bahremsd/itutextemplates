%This LaTeX template is implemented for Istanbul Technical University. 
%It combines elements from two existing projects: the work of Daan Zwaneveld
%(found at https://dzwaneveld.github.io) (licensed under CC BY-NC 4.0) and 
%Christian Nicolai Nielsen's DTU Thesis template (available at 
%https://www.designguide.dtu.dk).
%
%The goal of this template is to enhance and refine the (Xe)LaTeX template 
%implemented for students who want a well-designed and aesthetically pleasing
%thesis template from Istanbul Technical University. By integrating features 
%from both Zwaneveld's and Nielsen's templates, this version aims to simplify 
%the formatting process and provide additional improvements for thesis writers.
%
% Bahrem S. Danis (https://github.com/bahremsd)


%% Class is based on the default book class and options will be passed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{layout/itu-thesis}[23-05-2022 v1.0.0 Istanbul Technical University Thesis Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[10pt,oneside]{book}

%% Main packages in the document --- Some are imported later in the class file
\RequirePackage{mathtools}  % Mathematical tools to use with amsmath
\RequirePackage{amssymb}    % Extended symbol collection
\RequirePackage{siunitx}    % Comprehensive (SI) units package

\RequirePackage{tabularx}   % Tabulars with adjustable-width columns
\RequirePackage{booktabs}   % Publication quality tables
\RequirePackage{longtable}  % Allow tables to flow over page boundaries
\RequirePackage{multirow}   % Create tabular cells spanning multiple rows

\RequirePackage{graphicx}   % Enhanced support for images
\RequirePackage{float}      % Improved interface for floating objects
\RequirePackage[labelfont=bf,justification=centering,footnotesize]{caption} % Captions
\RequirePackage{subcaption} % Support for sub-captions
\RequirePackage{pdfpages}   % Include PDF documents

\RequirePackage[pdfusetitle,hidelinks]{hyperref} % Extensive support for hypertext
\RequirePackage[noabbrev]{cleveref} % Intelligent cross-referencing
\RequirePackage{xcolor}     % Driver-independent color extensions
\RequirePackage{tikz}       % Create PostScript and PDF graphics
\RequirePackage{xspace}     % Define commands that appear not to eat spaces
\RequirePackage{microtype}  % Refinements towards typographical perfection

\RequirePackage{geometry}   % Customize document dimensions
\RequirePackage{titlesec}   % Select alternative section titles
\RequirePackage{titletoc}   % Alternative headings for toc
\RequirePackage{fancyhdr}   % Control of page headers and footers
\RequirePackage{enumitem}   % Control layout of itemize, enumerate, description
\RequirePackage{etoolbox}   % Toolbox of programming facilities
\RequirePackage{iftex}      % Adds if-else statements to support multiple compilers
\RequirePackage{datetime}   % Change format of \today

%% Defining commands for the cover image, subtitle, subject, affiliation and table of authors
\newcommand*\subtitle[1]{\def\@subtitle{#1}}
\newcommand*\subject[1]{\def\@subject{#1}}
\newcommand*\affiliation[1]{\def\@affiliation{#1}}
\newcommand*\coverimage[1]{\def\@coverimage{#1}}
\newcommand*\covertable[1]{\def\@covertable{#1}}

%% Scaling the margins to be slightly smaller than default (.7)
\geometry{a4paper,hscale=0.75,vscale=0.8}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% I. Loading the fonts %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifPDFTeX
    %% pdfLaTeX is available for compatibility and uses a Paletino-like font
    \RequirePackage[T1]{fontenc}  % Selecting T1 font encoding
    \RequirePackage{charter}
    \RequirePackage[expert]{mathdesign}

    %% Another font can be used as the regular and large title style font if desired
    \def\titlestyle{\normalfont}
    \def\largetitlestyle{\normalfont}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% II. Adjusting the layout of the titles %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Formatting chapter titles and spacing
\titleformat{\chapter}[display]
    {\flushright}
    {\fontsize{96}{96}\selectfont\largetitlestyle\thechapter}
    {0pt}
    {\Huge\titlestyle}
\titlespacing*{\chapter}{0pt}{0pt}{2\baselineskip}

%% Formatting section titles and spacing
\titleformat{\section}
    {\Large\titlestyle\bfseries}
    {\thesection.}
    {5pt}
    {}
\titlespacing*{\section}{0pt}{\baselineskip}{0pt}

%% Formatting subsections titles and spacing
\titleformat{\subsection}
    {\large\titlestyle\bfseries}
    {\thesubsection.}
    {5pt}
    {}
\titlespacing*{\subsection}{0pt}{\baselineskip}{0pt}

%% Formatting subsubsections titles and spacing
\titleformat{\subsubsection}
    {\titlestyle\bfseries}
    {}
    {0pt}
    {}
\titlespacing*{\subsubsection}{0pt}{\bigskipamount}{0pt}

%% Reducing the vertical white space between chapters in the table of contents
\dottedcontents{chapter}[1.5em]{\vspace{0.5\baselineskip}\bfseries}{1.5em}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% III. Adjusting the header and footer %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Changing the header and footer of 'plain' pages
\fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[C]{\titlestyle\thepage}}

%% Changing the header and footer of 'fancy' pages (based on twoside option)
\if@twoside
    \fancyhf{}
    \fancyhead[LE,RO]{\titlestyle\thepage}
    \fancyhead[RE]{\titlestyle\nouppercase{\leftmark}}
    \fancyhead[LO]{\titlestyle\nouppercase{\rightmark}}
    \RequirePackage{emptypage} % Remove header and footer on empty pages
\else
    \fancyhf{}
    \fancyhead[R]{\titlestyle\thepage}
    \fancyhead[L]{\titlestyle\nouppercase{\rightmark}}
\fi

\pagestyle{fancy} % Setting the package defaults and the additional changes as the style

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% IV. Creating the cover page %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*\makecover{

\usetikzlibrary{positioning}
\thispagestyle{empty}

\begin{titlepage}
\pagecolor{frontbackcolor}
\color{blue}

{ % Thesis title (to change see Setup/Settings.tex) 
\Huge
\begin{tabular}{p{\linewidth}}
\TitleFont{sdfghjerth}   \\ 
\titlefont{asdfghj} \bigskip \\ 
{\huge \documenttype}
\end{tabular}
}

% ITU Department
\begin{tikzpicture}[remember picture,overlay]
\node[anchor=north east, 
      xshift=-10mm, 
      yshift=-12mm] 
      at (current page.north east) 
      {
        \color{\frontpagetextcolour}
        \begin{tabular}{r} 
        \textbf{asdasdasd asdasdas} \\ 
        \departmentdescriber
        \end{tabular}
      }; 
\end{tikzpicture}

% ITU logo
\begin{tikzpicture}[remember picture,overlay]
\node[anchor=north west, 
      xshift=8.9mm, 
      yshift=-8.3mm] 
     at (current page.north west) 
     {\includegraphics[width=14.75mm,keepaspectratio]{structure/structure_figures/itu_white_logo.pdf}}; 
\end{tikzpicture}

% Thesis Cover Photo
\begin{tikzpicture}[remember picture,overlay]
\node[anchor=south, % anchor is bottom of picture
      xshift=0pt, 
      yshift=-2.9mm] % shifting picture to actually be at the bottom of the page
     at (current page.south) % placement at bottom of the page
     {\includegraphics[height=18.9cm,keepaspectratio]{structure/structure_figures/itu_thesis_cover_photo.jpg}};
\end{tikzpicture}
    \newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% V. Setting up listings %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{listings} % Typeset source code listings

\lstset{
  basicstyle=\ttfamily\footnotesize,  % Style of the font that is used for the code
  backgroundcolor=\color{gray!10},    % Background color
  keywordstyle=\color{red!75!black},  % Keyword style
  stringstyle=\color{green!40!black}, % String style
  commentstyle=\color{blue!30!black}, % Comment style
  numbers=left,                       % Add line numbers on the left side
  numbersep=5pt,                      % Decrease distance between line numbers and code
  numberstyle=\tiny,                  % Line number style
  breaklines=true,                    % Line break automatically
}