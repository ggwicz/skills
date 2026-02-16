# Severity Rubric

Use these definitions to classify each finding.

## High — Actively confusing

The reader may misunderstand, take the wrong action, or give up. Fix these first.

**Triggers:** ambiguous pronoun references, buried main idea (exception before rule), passive voice hiding who is responsible, double negatives, long sentences with multiple embedded clauses.

| Before | After | Why high |
|--------|-------|----------|
| The database will be initialized by the setup script after the configuration is validated by the system. | The system validates the configuration, then the setup script initializes the database. | Two stacked passives — reader can't tell what runs first or who does what. |
| Except when the API key has not been set, the request will not fail to authenticate unless the token is invalid. | The request authenticates if the API key is set and the token is valid. | Triple negative — reader must mentally invert three times. |
| It must be done before deployment. | You must complete the migration before deployment. | "It" is ambiguous, "must be done" hides the actor. |

## Medium — Unnecessarily complex

The reader can figure it out but has to work harder than needed. Fix after high-severity items.

**Triggers:** jargon when a simpler word exists, hidden verbs (nominalizations), sentences over ~30 words, unnecessary abbreviations, inconsistent terminology, excess modifiers (really, very, basically, totally), redundant word pairs/doublets ("each and every", "null and void").

| Before | After | Why medium |
|--------|-------|------------|
| In order to utilize the configuration module, you must first perform the initialization of the settings. | To use the configuration module, first initialize the settings. | "In order to," "utilize," and "perform the initialization of" are all unnecessarily complex. |
| The endpoint facilitates the retrieval of user data. | The endpoint retrieves user data. | Hidden verb ("facilitates the retrieval") buries the real action. |
| RBAC policies should be configured via the IAM dashboard prior to commencing the deployment process. | Set up role-based access control in the IAM dashboard before you deploy. | Jargon (RBAC without definition), hidden verb ("commencing the deployment process"), and "prior to" for "before." |

## Low — Minor polish

Readable but could be tighter. Address if time permits.

**Triggers:** missing contractions where they'd sound natural, series that would read better as a list, missing transition words, vague headings, slightly wordy phrasing.

| Before | After | Why low |
|--------|-------|---------|
| You will need to install the dependencies, configure the environment variables, and then run the test suite. | You'll need to: (1) install dependencies, (2) configure environment variables, and (3) run the test suite. | Readable as-is, but a list makes it scannable. |
| It is not possible to undo this action. | You can't undo this action. | Readable, but "It is not possible" is wordier than needed. |
| Configuration | How to configure the app | Heading is vague — a statement or question heading is clearer. |
