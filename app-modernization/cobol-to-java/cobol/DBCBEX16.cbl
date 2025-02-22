      **********************************************************
      * Program name:    DBCBEX16
      * Original author: David Stagowski
      *
      *    Description: Example 1-6: DB2 Processing: Read All with View
      *
      *    This program will read all the records using a View supplied
      *    by the DB and print a nice report.

      *    There are some differences between the GnuCOBOL and
      *       ZOS DB2 programs.
      *
      *    The biggest difference is the 9800-Connect-to-DB1 paragraph.
      *
      *    On ZOS, the JCL makes the connection so there is no need for
      *       passing the username and password for the database.
      *
      *    That is required with GnuCOBOL.
      *    These GnuCOBOL programs use GETDBID, a very simple called
      *    module that has the username and password embedded in it.
      *    When called, it passes them up to the calling program which
      *    then uses them to make the connection to the server.
      *
      * Maintenance Log
      * Date       Author        Maintenance Requirement
      * ---------- ------------  --------------------------------
      * 2020-08-29 dastagg       Created to learn.
      * 20XX-XX-XX               If you change me, change this.
      *
      **********************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DBCBEX16.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      * SOURCE-COMPUTER.   IBM WITH DEBUGGING MODE.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT EMPRPT
           ASSIGN TO EMPRPT
           ORGANIZATION IS SEQUENTIAL
           FILE STATUS IS WS-EmpRpt-Status.

       DATA DIVISION.
       FILE SECTION.
       FD  EMPRPT
           RECORDING MODE IS F
           BLOCK CONTAINS 0 RECORDS.
       01  Print-Line        PIC X(131).

       WORKING-STORAGE SECTION.

           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.

       01  HV-Employee-Row.
           12 HV-Emp-Number           PIC X(06).
           12 HV-First-Name           PIC X(12).
           12 HV-Middle-Init          PIC X(01).
           12 HV-Last-Name            PIC X(15).
           12 HV-Work-Dept            PIC X(03).

           EXEC SQL DECLARE DB1-C1 CURSOR FOR
                    SELECT EMPNO,
                           FIRSTNME,
                           MIDINIT,
                           LASTNAME,
                           WORKDEPT
                    FROM VEMP
           END-EXEC.

       01 WS-SQL-STATUS                PIC S9(9) COMP-5.
          88 SQL-STATUS-OK             VALUE    0.
          88 SQL-STATUS-NOT-FOUND      VALUE  100.
          88 SQL-STATUS-DUP            VALUE -803.

       01  WS-FILE-STATUS.
           COPY WSFST REPLACING ==:tag:== BY ==EmpRpt==.

       01  CURRENT-DATE-AND-TIME.
           COPY WSDT REPLACING ==:tag:== BY ==CDT==.

       01  WS-Counters.
           12 WS-Employee-Record-Cnt  PIC 9(4) COMP.

       01  R1-Counters.
           12 R1-Max-Lines         PIC 9(4) COMP VALUE 60.
           12 R1-Line-Count        PIC 9(4) COMP VALUE ZEROES.
           12 R1-Line-Advance      PIC 9(4) COMP VALUE ZEROES.
           12 R1-Page-Count        PIC 9(4) COMP VALUE ZEROES.

       01  R1-Page-Header.
           12 FILLER                   PIC X(006) VALUE "Date: ".
           12 R1-HDR-DATE.
              15 R1-HDR-YY             PIC 9(4).
              15 FILLER                PIC X(1) VALUE "-".
              15 R1-HDR-MM             PIC 9(2).
              15 FILLER                PIC X(1) VALUE "-".
              15 R1-HDR-DD             PIC 9(2).
           12 FILLER                   PIC X(021) VALUE SPACE.
           12 FILLER                   PIC X(034)
                 VALUE "    Sample DB Employee Report     ".
           12 FILLER                   PIC X(049) VALUE SPACE.
           12 FILLER                   PIC X(005) VALUE "Page:".
           12 FILLER                   PIC X(001) VALUE SPACE.
           12 R1-HDR-Page-Count        PIC ZZ9.

       01  R1-Column-Header1.
           12 FILLER   PIC X(003) VALUE "Emp".
           12 FILLER   PIC X(004) VALUE SPACES.
           12 FILLER   PIC X(005) VALUE "First".
           12 FILLER   PIC X(010) VALUE SPACES.
           12 FILLER   PIC X(004) VALUE "Last".

       01  R1-Column-Header2.
           12 FILLER   PIC X(006) VALUE "Number".
           12 FILLER   PIC X(001) VALUE SPACES.
           12 FILLER   PIC X(004) VALUE "Name".
           12 FILLER   PIC X(011) VALUE SPACES.
           12 FILLER   PIC X(004) VALUE "Name".
           12 FILLER   PIC X(012) VALUE SPACES.
           12 FILLER   PIC X(002) VALUE "WD".

       01  R1-Column-Header3.
           12 FILLER    PIC X(006) VALUE ALL "=".
           12 FILLER    PIC X(001) VALUE ALL SPACES.
           12 FILLER    PIC X(012) VALUE ALL "=".
           12 FILLER    PIC X(001) VALUE ALL SPACES.
           12 FILLER    PIC X(001) VALUE ALL "=".
           12 FILLER    PIC X(001) VALUE ALL SPACES.
           12 FILLER    PIC X(015) VALUE ALL "=".
           12 FILLER    PIC X(001) VALUE ALL SPACES.
           12 FILLER    PIC X(003) VALUE ALL "=".

       01  R1-Detail-Line.
           12 R1-Emp-Number           PIC X(06).
           12 FILLER                  PIC X(001) VALUE SPACES.
           12 R1-First-Name           PIC X(12).
           12 FILLER                  PIC X(001) VALUE SPACES.
           12 R1-Middle-Init          PIC X(01).
           12 FILLER                  PIC X(001) VALUE SPACES.
           12 R1-Last-Name            PIC X(15).
           12 FILLER                  PIC X(001) VALUE SPACES.
           12 R1-Work-Dept            PIC X(03).
           12 FILLER                  PIC X(001) VALUE SPACES.

       01  R1-Footer1.
           12 FILLER             PIC X(036)
              VALUE "Number of Employees in this Report: ".
           12 FILLER             PIC X VALUE SPACE.
           12 R1-Total-Recs-Read PIC ZZ9.

       01 EOJ-Display-Messages.
           12 EOJ-End-Message PIC X(042) VALUE
              "*** Program DCBCEX16 - End of Run Messages".

       PROCEDURE DIVISION.
       0000-Mainline.
           PERFORM 1000-Begin-Job.
           PERFORM 2000-Process.
           PERFORM 3000-End-Job.
           GOBACK.

       1000-Begin-Job.
           PERFORM 9800-Connect-to-DB1.
           IF SQL-STATUS-OK
              OPEN OUTPUT EMPRPT
              PERFORM 6101-Setup-R1
              PERFORM 6110-Write-R1-Page-Header
              PERFORM 5000-Read-DB1
           END-IF.

       2000-Process.
           PERFORM 2100-Process-Data
              UNTIL NOT SQL-STATUS-OK.

       2100-Process-Data.
           IF SQL-STATUS-OK
              PERFORM 2110-Move-Detail-Data
              MOVE 1 TO R1-Line-Advance
              PERFORM 6100-Write-R1
              PERFORM 5000-Read-DB1
           END-IF.

       2110-Move-Detail-Data.
           MOVE HV-Emp-Number TO R1-Emp-Number.
           MOVE HV-First-Name TO R1-First-Name.
           MOVE HV-Middle-Init TO R1-Middle-Init.
           MOVE HV-Last-Name TO R1-Last-Name.
           MOVE HV-Work-Dept TO R1-Work-Dept.

       3000-End-Job.
           EXEC SQL CLOSE DB1-C1 END-EXEC.
           MOVE SQLCODE TO WS-SQL-STATUS.

           EXEC SQL CONNECT RESET END-EXEC.
           MOVE SQLCODE TO WS-SQL-STATUS.
           MOVE WS-Employee-Record-Cnt TO R1-Total-Recs-Read.
           PERFORM 6130-Write-R1-Footer.
           CLOSE EMPRPT.
           DISPLAY EOJ-End-Message.

       5000-Read-DB1.
           EXEC SQL FETCH DB1-C1
              INTO
                 :HV-Emp-Number,
                 :HV-First-Name,
                 :HV-Middle-Init,
                 :HV-Last-Name,
                 :HV-Work-Dept
           END-EXEC.
           MOVE SQLCODE TO WS-SQL-STATUS.
           IF SQL-STATUS-OK
              ADD +1 TO WS-Employee-Record-Cnt
           ELSE
              IF SQL-STATUS-NOT-FOUND
                 NEXT SENTENCE
              ELSE
                 DISPLAY "*** WARNING ***"
                 DISPLAY "There was a problem Fetching the cursor."
                 DISPLAY "SQLCODE = " SQLCODE
                 PERFORM 3000-End-Job
                 MOVE 8 TO RETURN-CODE
                 GOBACK
              END-IF
           END-IF.

       6100-Write-R1.
           IF R1-Line-Count + R1-Line-Advance > R1-Max-Lines
              PERFORM 6110-Write-R1-Page-Header
              PERFORM 6120-Write-R1-Detail
           ELSE
              PERFORM 6120-Write-R1-Detail
           END-IF.

       6101-Setup-R1.
           MOVE FUNCTION CURRENT-DATE TO CURRENT-DATE-AND-TIME.
           MOVE CDT-Year     TO R1-HDR-YY.
           MOVE CDT-Month    TO R1-HDR-MM.
           MOVE CDT-Day      TO R1-HDR-DD.

       6110-Write-R1-Page-Header.
           ADD +1 TO R1-Page-Count.
           MOVE R1-Page-Count TO R1-HDR-Page-Count.
           WRITE Print-Line FROM R1-Page-Header
              AFTER ADVANCING PAGE.
           WRITE Print-Line FROM R1-Column-Header1
              AFTER ADVANCING 2.
           WRITE Print-Line FROM R1-Column-Header2
              AFTER ADVANCING 1.
           WRITE Print-Line FROM R1-Column-Header3
              AFTER ADVANCING 1.
           MOVE 5 TO R1-Line-Count.

       6120-Write-R1-Detail.
           MOVE R1-Detail-Line TO Print-Line.
           WRITE Print-Line
              AFTER ADVANCING R1-Line-Advance LINES.
           ADD R1-Line-Advance TO R1-Line-Count.

       6130-Write-R1-Footer.
           IF R1-Line-Count + 3 > R1-Max-Lines
              PERFORM 6110-Write-R1-Page-Header
           END-IF.
           MOVE R1-Footer1 TO Print-Line.
           WRITE Print-Line
              AFTER ADVANCING 2 LINES.
           PERFORM 6140-Display-EOJ-Messages.

       6140-Display-EOJ-Messages.
           DISPLAY EOJ-End-Message.

       9800-Connect-to-DB1.
           PERFORM 9810-Setup-DB1-Connection.
           IF SQL-STATUS-OK
              CONTINUE
           ELSE
              DISPLAY "*** The DB connection is not valid!***"
              DISPLAY "Exiting the program.!"
              GOBACK
           END-IF.

       9810-Setup-DB1-Connection.
           PERFORM 9812-Create-Connection-To-DB1.

       9812-Create-Connection-To-DB1.
           IF SQL-STATUS-OK
              PERFORM 9816-Create-Cursor-DB1
              IF SQL-STATUS-OK
                 PERFORM 9818-Open-Cursor-DB1
              END-IF
           END-IF.

       9816-Create-Cursor-DB1.
      *    Parms for DB1-C1
      *D     DISPLAY "Nothing to do here.".
      *    As an example:
      *     MOVE "DESIGNER" TO HV-Job-Title.

       9818-Open-Cursor-DB1.
           EXEC SQL OPEN DB1-C1 END-EXEC.
           MOVE SQLCODE TO WS-SQL-STATUS.