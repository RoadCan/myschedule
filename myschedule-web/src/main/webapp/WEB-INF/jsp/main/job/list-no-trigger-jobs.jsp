<%@ include file="/WEB-INF/jsp/main/page-a.inc" %>
<script>
$(document).ready(function() {
	$('#tabs').tabs({
	    select: function(event, ui) {
	        var url = $.data(ui.tab, 'load.tabs');
	        if( url ) {
	            location.href = url;
	            return false;
	        }
	        return true;
	    }
	});

	// Use dataTables plugin
	$("#jobs").dataTable({
		"aaSorting": [[0, "asc"]],
		"iDisplayLength": 50,
		"bJQueryUI": true,
		"sPaginationType": "full_numbers"
	});

	// Confirm unschedule job
	$("#delete-confirm").hide();
	$("#jobs .action a + a").click(function() {
		var linkUrl = $(this).attr("href");
		$("#delete-confirm").dialog({
			resizable: false,
			height:200,
			width:400,
			modal: true,
			buttons: {
				"Yes": function() {
					window.location.href=linkUrl;
				},
				Cancel: function() {
					$(this).dialog("close");
				}
			}
		});
		return false;
	});
});
</script>

<div id="delete-confirm" title="Delete Job?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
	Are you sure you want to remove this job from the scheduler?
	</p>
</div>

<div id="tabs">
	<ul>
	<li><a href="#">Jobs with trigger</a></li>
	<li><a href="${ mainPath }/job/ajax/list-no-trigger-jobs">Jobs without trigger</a></li>
	<li><a href="${ mainPath }/job/ajax/list-executing-jobs">Currently Executing Jobs</a></li>
	</ul>
	
	<div id="tabs-1">

		<h1>Jobs without assigned trigger</h1>
		<table id="jobs" class="display">
			<thead>
			<tr>
				<th> JOB </th>
				<th> JOB CLASS </th>
				<th> ACTIONS </th>
			</tr>
			</thead>
			
			<tbody>
			<c:forEach items="${ data.jobWithoutTriggerList }" var="jobDetail">
			<tr>
				<td><a href="${ mainPath }/job/job-detail?jobName=${ jobDetail.key.name }&jobGroup=${ jobDetail.key.group }">${ jobDetail.key }</a></td>
				<td>${ jobDetail.jobClass.name }</td>
				<td class="action">
					<a href="${ mainPath }/job/run-job?jobName=${ jobDetail.key.name }&jobGroup=${ jobDetail.key.group }">Run It Now</a> |
					<a href="${ mainPath }/job/delete?jobName=${ jobDetail.key.name }&jobGroup=${ jobDetail.key.group }">Delete</a>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table> <!-- jobs-without-triggers -->
	</div>
</div>
<%@ include file="/WEB-INF/jsp/main/page-b.inc" %>