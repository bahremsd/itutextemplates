%The ituletter LaTeX class originates from Nesime Tatbul's "brownletter" class (2003, tatbul@cs.brown.edu), 
%who adapted it from the letter template for Brown University. We thank Nesime Tatbul for creating this class.
%
%This template aims that mails from ITU maintain a high standard of professionalism and clarity. 
%The "ituletter" class, based on LaTeX's standard letter class, incorporates specific formatting
%to estatic needs, including custom margins, header and footer settings, and the inclusion of 
%ITU's logo. It also provides commands to easily add a subject line and format the opening and 
%closing sections of a letter.
%
%The template automatically adjusts the layout to use letter paper size, sets the text width and 
%height, and positions the header and footer appropriately, making it ideal for official correspondence. 
%By using this class, ITU faculty and staff generate consistent and polished letters.
%
%
% Please contact bdanis23@ku.edu.tr to report any problems or bugs.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ituletter}
\RequirePackage{graphicx}
\RequirePackage{ifthen}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} % we always use letter paper

\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}


\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.0in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newsavebox{\departmentfoot}
\newsavebox{\emptyfoot}

\sbox{\departmenthead}{
    \begin{tabular*}{\textwidth}
                    {@{}l@{\extracolsep{0.0in}}|@{\extracolsep{0.125in}}l@{}}
    \parbox{4.625in}{\raggedright
        \ifthenelse{\boolean{true}}
           {\includegraphics[width=7.2cm]{itu_navyblue_logo.pdf}}
           {\parbox[t][1.0in][t]{2.0in}{\hfill}}
    } &
    \parbox[t][1.0in]{2.125in}{{\xcmrbn Istanbul Technical University\\Department of XXXXX}\\
                               {\ixcmrmn https://www.itu.edu.tr/en/homepage}}\\
    \end{tabular*}
}

\savebox{\departmentfoot}[\textwidth][c]{\ixcmrmn
    Istanbul Technical University
    ~Box ITU Ayazaga Campus, XXX Building
    ~TEL: 444-X-XXX
    ~FAX: +90 212 XXX XX XX
}

\savebox{\emptyfoot}[\textwidth][c]{\ixcmrmn
    \hspace*{\textwidth}
}

% header and footer should be placed only on the first page
\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{0.5in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{\usebox{\emptyfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\usebox{\emptyfoot}}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}

% we add the subject command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        {\raggedleft\@date\par}%
    \else  % home address
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            \@date 
            \end{tabular}\par
        }%
     \fi
     \vspace{1\parskip}%
     {\raggedright \toname \\ \toaddress \par}%
     \vspace{1\parskip}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}%
     #1\par\nobreak
}

% we push closing to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \hspace*{0.0\textwidth}\parbox{0.4\textwidth}{\raggedright
    \ignorespaces #1\\[4\medskipamount]%
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut}%
    \par
}