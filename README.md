# archivesspace_scripts
Utility scripts for working with ArchivesSpace


## alphabetize_relators.rb

A Ruby script to alphabetize the list of MARC relators.

ArchivesSpace, by default, splits relators into two alphabetical lists (as an artifact of how the terms were loaded into the system).  This causes issues when searching the list of relators.  `alphabetize_relators.rb` will sort the list of relators alphabetically (by relator code), so that there will no longer be two sub-lists of terms.