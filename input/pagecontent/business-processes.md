
#### Overview of Business Processes
A business process, or process, is a set of related activities or tasks performed together to achieve the objectives of the health Programme area, such as registration, counseling, and referrals. 
Workflows are a visual representation of the progression of activities (tasks, events, and interactions) that are performed within the business process. The workflow provides a story for the business process being diagrammed and is used to enhance communication and collaboration among users, stakeholders, and engineers.


#### Table 3: Business process symbols used in workflows

<table border="1" class="dataframe table table-striped table-bordered">
  <thead>

    <tr>
      <th>Symbol</th>
      <th>Symbol Name</th>
      <th>Description</th>
    </tr>

  </thead>
  <tbody>
  <tr>

      <td><img src="swim-lane.png" alt="swim-lane" style="width:85%"/></td>
      <td>Swim lane</td>
      <td>Each individual or type of user is assigned to a swim lane, a designated area for noting the activities performed or expected of that specific actor. For example, a family planning health worker may have one swim lane; the supervisor would be in another swim lane; the clients/patients would be classified in another swim lane. If the activities can be performed by either actor, then those activities can be depicted overlapping the two relevant swim lanes.</td>
    </tr>
    <tr>
      <td><img src="start-event.png" alt="start-event" style="width:85%"/></td>
      <td>Start event or Trigger event</td>
      <td>The workflow diagram should contain both a start and an end event, defining the beginning and completion of the task, respectively.</td>
    </tr>
    <tr>
      <td><img src="end-event.png" alt="end-event" style="width:85%"/></td>
      <td>End event</td>
      <td>There can be multiple end events depicted across multiple swimlanes in a business process diagram. However, for diagram clarity, there should only be one end event per swim lane.</td>
    </tr>
    <tr>
      <td><img src="activity.png" alt="activity" style="width:85%"/></td>
      <td>Activity, Process, Step or Task</td>
      <td>Each activity should start with a verb, e.g., “Register client”, “Calculate risk”. Between the start and end of a task, there should be a series of activities noted - in the successive actions performed by the actor for that swim lane. There can also be sub-processes within each activity.</td>
    </tr>
    <tr>
      <td><img src="activity-with-sub-process.png" alt="activity-with-sub-process" style="width:85%"/></td>
      <td>Activity with sub-process</td>
      <td>This symbol denotes an activity that has a much longer sub-process, to be detailed in another diagram. If the diagram starts to become too complex and unhelpful, the sub-process symbol should be used to reference this sub-another process depicted on another diagram page. (Activity with sub-process in grey box is not covered in this DAK).</td>
    </tr>
    <tr>
      <td><img src="sequence-flow.png" alt="sequence-flow" style="width:85%"/></td>
      <td>Sequence flow</td>
      <td>This symbol denotes the flow direction from one process to the next. The end event should not have any output arrows. All symbols (except the Start event) may have an unlimited number of input arrows. All symbols (except the end event and the Gateway) should have one and only one output arrow, leading to a new symbol, looping back to a previously used symbol, or pointing to the End event symbol. Connecting arrows should not intersect (cross) each other.</td>
    </tr>
    <tr>
      <td><img src="gateway.png" alt="gateway" style="width:85%"/></td>
      <td>Gateway</td>
      <td>This symbol is used to depict a fork, or decision point, in the workflow, which may be a simple binary (for example, yes/no) filter with two corresponding output arrows or a different set of outputs. In this document, there should typically be only two different outputs that originate from the decision point. If you find yourself needing more than two “output” or sequence flow direction arrows, this is most likely trying to depict “decision-support logic” or a “business rule”. This should be depicted as an “Activity with business rule”.</td>
    </tr>
    <tr>
      <td><img src="throw-link.png" alt="throw-link" style="width:85%"/></td>
      <td>Throw – Link</td>
      <td>The “Throw–Link” serves as the start of an off-page connector. It is the end of the process when there is no more room on your page for that workflow. It is the end of a process on your current page or the end of a sub-process that is part of a larger process. When used, there will need to be a corresponding “Catch–Link” on the other page that shows the continuation of the workflow that follows the “Throw–Link”.</td>
    </tr>
    <tr>
      <td><img src="catch-link.png" alt="catch-link" style="width:85%"/></td>
      <td>Catch – Link</td>
      <td>The “Catch–Link” serves as an off-page connector. It is the start of a new process that follows a previous process, a continuation of a process from a previous page, on a different page from the “Throw – Link” or the start of a sub-process that is part of a larger process. Every “CatchLink” needs to align with at least one corresponding “Throw–Link” that is aligned to the prior process diagram “Catch–Link”.</td>
    </tr>
    <tr>
      <td><img src="loop-activity.png" alt="loop-activity" style="width:85%"/></td>
      <td>Loop Activity</td>
      <td>This “Loop Activity” or loop task symbolizes an activity or task that is repeated until it no longer needs to be repeated. For example, vaccine administration can happen as many times as the number of vaccines that need to be given.</td>
    </tr>

  </tbody>
  </table>

The overview of the business processes in this DAK captures all business processes at a high level.

 <div> 
<img src="workflow-summary-bpmn.png" alt="summary" style="width:85%"/>
</div>

### Workflows

#### Self Registration 

<b> Objective: </b> To register and uniquely identify vaccination locations in order to administer vaccines and enable appropriate tracking of vaccine coverage and stock.
 
 <div> 
<img src="workflow-a-self-registration.png" alt="workflow-a-self-registration.png" style="width:85%"/>
</div>
<br>

#### Client Registration

<b> Objective: </b> To prepare for an immunization session, either at the vaccination location or done at an outreach site.
 
 <div> 
<img src="workflow-b-client-registration.png" alt="workflow-b-client-registration.png" style="width:85%"/>
</div>
<br>

#### Prescription Generation

<b> Objective: </b> To start the client’s lifelong immunization record.
 
 <div> 
<img src="workflow-c-prescription-generation.png" alt="workflow-c-prescription-generation.png" style="width:85%"/>
</div>
<br>

#### Prescription Processing
<b> Objective: </b> To determine what vaccines a client needs, administer those, and record the data both in the system and on the client’s vaccination card.
 <div> 
<img src="workflow-d-prescription-processing.png" alt="workflow-d-prescription-processing.png" style="width:85%"/>
</div>
<br>

#### Billing
<b> Objective: </b> To manage caregiver reports or client presenting at health facilities with cases of AEFI based on set triggers.
 
 <div> 
<img src="workflow-e-billing.png" alt="workflow-e-billing.png" style="width:85%"/>
</div>
<br>

#### Medication Preparation and Dispensing
<b> Objective: </b> To send vaccination reminders to community health workers that certain clients are due for vaccination.
 
 <div> 
<img src="workflow-f-medication-dispensing.png" alt="workflow-f-medication-dispensing.png" style="width:85%"/>
</div>
<br>

#### Medication Delivery
<b> Objective: </b> To identify clients that are overdue for follow-up
 
 <div> 
<img src="workflow-g-medication-delivery.png" alt="workflow-g-medication-delivery.png" style="width:85%"/>
</div>
<br>

#### Patient Counseling and Education
<b> Objective: </b> To identify clients that are overdue for follow-up
 
 <div> 
<img src="workflow-h-counseling-education.png" alt="workflow-h-counseling-education.png" style="width:85%"/>
</div>
<br>


#### Medication Followup and Monitoring
<b> Objective: </b> To identify clients that are overdue for follow-up
 
 <div> 
<img src="workflow-i-medication-follow-up.png" alt="workflow-i-medication-follow-up.png" style="width:85%"/>
</div>
<br>

#### Adverse Drug Reaction and management
<b> Objective: </b> To provide data access and analysis for decision-making
 
 <div> 
<img src="workflow-h-adverse-drug-management.png" alt="workflow-h-adverse-drug-management.png" style="width:85%"/>
</div>
<br>

#### Medication Preparation and Dispensing
<b> Objective: </b> To ensure accurate and unified client data by identifying and merging duplicate records.
 
 <div> 
<img src="workflow-i-medication-dispensing.png" alt="workflow-i-medication-dispensing.png" style="width:85%"/>
</div>
<br>

#### Process Payment
<b> Objective: </b> To maintain reliable immunization records by detecting and resolving duplicate vaccination entries.
 
 <div> 
<img src="workflow-e-billing.png" alt="workflow-j-process-payment.png" style="width:85%"/>
</div>
<br>


#### Medication Delivery
<b> Objective: </b> To maintain reliable immunization records by detecting and resolving duplicate vaccination entries.
 
 <div> 
<img src="workflow-k-medication-delivery.png" alt="workflow-k-medication-delivery.png" style="width:85%"/>
</div>
<br>

#### Medication Delivery
<b> Objective: </b> To maintain reliable immunization records by detecting and resolving duplicate vaccination entries.
 
 <div> 
<img src="workflow-l-record-compliance.png" alt="workflow-l-record-compliance.png" style="width:85%"/>
</div>
<br>

#### Update Drug Catalogue
<b> Objective: </b> To maintain reliable immunization records by detecting and resolving duplicate vaccination entries.
 
 <div> 
<img src="workflow-l-record-compliance.png" alt="workflow-m-drug-catalogue.png" style="width:85%"/>
</div>
<br>
 