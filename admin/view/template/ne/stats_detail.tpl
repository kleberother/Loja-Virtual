<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------
?>
<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/ne/stats.png" alt="" width="22" height="22" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
        <table class="form">
          <tr>
            <td>
            	<h2><?php echo $entry_heading; ?></h2>
            	<table id="ne_stats_info">
			      <tr>
			        <td class="name"><?php echo $entry_total_recipients; ?></td>
			        <td><?php echo $recipients_total; ?></td>
			      </tr>
            <tr>
              <td class="name"><?php echo $entry_total_views; ?></td>
              <td><?php echo $views_total; ?></td>
            </tr>
			      <tr>
			        <td class="name green"><?php echo $entry_sent; ?></td>
			        <td class="green"><?php echo $detail['queue'] - $failed_total; ?> / <?php echo $detail['recipients']; ?> (<?php echo ($detail['recipients'] ? floor(($detail['queue'] - $failed_total) / $detail['recipients'] * 100) : 0); ?>%)</td>
			      </tr>
			      <tr>
			        <td class="name green"><?php echo $entry_read; ?></td>
			        <td class="green"><?php echo $detail['read']; ?> / <?php echo $detail['queue']; ?> (<?php echo ($detail['queue'] ? floor($detail['read'] / $detail['queue'] * 100) : 0); ?>%)</td>
			      </tr>
				  <tr>
					<td class="name red"><?php echo $entry_total_failed; ?></td>
					<td class="red"><?php echo $failed_total; ?></td>
				  </tr>
				  <?php if ($this->config->get('ne_bounce')) { ?>
				  <tr>
					<td class="name red"><?php echo $entry_total_bounced; ?></td>
					<td class="red"><?php echo $bounced_total; ?></td>
				  </tr>
				  <?php } ?>
			      <tr>
			        <td class="name red"><?php echo $entry_unsubscribe_clicks; ?></td>
			        <td class="red"><?php echo $detail['unsubscribe_clicks']; ?></td>
			      </tr>
			    </table>
            </td>
          </tr>
          <?php if ($detail['tracks']) { ?>
          <tr>
            <td>
            	<h2><?php echo $entry_track; ?></h2>
            	<table class="ne_stats_track">
            		<thead>
            			<tr>
			        		<th><?php echo $entry_url; ?></th>
			        		<th><?php echo $entry_clicks; ?></th>
			        	</tr>
            		</thead>
            	  	<tbody>
            	  		<?php foreach ($detail['tracks'] as $entry) { ?>
            	  		<tr>
							<td><a href="<?php echo $entry['url']; ?>" target="_blank"><?php echo $entry['url']; ?></a></td>
							<td><?php echo $entry['clicks']; ?></td>
						</tr>
						<?php } ?>
            	  	</tbody>
			    </table>
            </td>
          </tr>
          <?php } ?>
          <?php if ($attachements) { ?>
          <tr>
            <td>
            	<h2><?php echo $entry_attachements; ?></h2>
            	<?php foreach ($attachements as $key => $attachement) { ?>
            	<?php echo ($key + 1) . '. '; ?><a href="<?php echo $store_url . $attachement['path']; ?>" target="_blank"><?php echo $attachement['filename']; ?></a><br/>
            	<?php } ?>
            </td>
          </tr>
          <?php } ?>
          <tr>
            <td>
            	<h2><?php echo $entry_timeline; ?></h2>
            	<div id="chart_div" style="width:858px;height:300px;"></div>
            </td>
          </tr>
          <tr>
            <td>
            	<h2><?php echo $entry_recipients; ?></h2>
            	<table class="list">
					<thead>
						<tr>
							<td class="left">
								<?php if ($sort == 'name') { ?>
								<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
								<?php } ?>
							</td>
							<td class="left">
								<?php if ($sort == 'c.email') { ?>
								<a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_email; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_email; ?>"><?php echo $column_email; ?></a>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($sort == 's.views') { ?>
								<a href="<?php echo $sort_views; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_views; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_views; ?>"><?php echo $column_views; ?></a>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($sort == 'clicks') { ?>
								<a href="<?php echo $sort_clicks; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_clicks; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_clicks; ?>"><?php echo $column_clicks; ?></a>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($sort == 'success') { ?>
								<a href="<?php echo $sort_success; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_success; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_success; ?>"><?php echo $column_success; ?></a>
								<?php } ?>
							</td>
							<?php if ($this->config->get('ne_bounce')) { ?>
							<td class="right">
								<?php if ($sort == 'bounced') { ?>
								<a href="<?php echo $sort_bounced; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_bounced; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_bounced; ?>"><?php echo $column_bounced; ?></a>
								<?php } ?>
							</td>
							<?php } ?>
							<td class="right"><?php echo $column_actions; ?></td>
						</tr>
					</thead>
					<tbody>
						<tr class="filter">
							<td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
							<td><input type="text" name="filter_email" value="<?php echo $filter_email; ?>" /></td>
							<td></td>
							<td></td>
							<td class="right">
								<select name="filter_success">
									<option value=""></option>
									<?php if ($filter_success == '1') { ?>
									<option value="1" selected="selected"><?php echo $entry_yes; ?></option>
									<?php } else { ?>
									<option value="1"><?php echo $entry_yes; ?></option>
									<?php } ?>
									<?php if ($filter_success == '0') { ?>
									<option value="0" selected="selected"><?php echo $entry_no; ?></option>
									<?php } else { ?>
									<option value="0"><?php echo $entry_no; ?></option>
									<?php } ?>
								</select>
							</td>
							<?php if ($this->config->get('ne_bounce')) { ?>
							<td class="right">
								<select name="filter_bounced">
									<option value=""></option>
									<?php if ($filter_bounced == '1') { ?>
									<option value="1" selected="selected"><?php echo $entry_yes; ?></option>
									<?php } else { ?>
									<option value="1"><?php echo $entry_yes; ?></option>
									<?php } ?>
									<?php if ($filter_bounced == '0') { ?>
									<option value="0" selected="selected"><?php echo $entry_no; ?></option>
									<?php } else { ?>
									<option value="0"><?php echo $entry_no; ?></option>
									<?php } ?>
								</select>
							</td>
							<?php } ?>
							<td align="right"><a onclick="filter();" class="button"><span><?php echo $button_filter; ?></span></a></td>
						</tr>
						<?php if ($recipients) { ?>
							<?php foreach ($recipients as $recipient) { ?>
						<tr>
							<td class="left"><?php echo isset($recipient['name']) ? $recipient['name'] : ''; ?></td>
							<td class="left"><?php echo $recipient['email']; ?></td>
							<td class="right"><?php echo $recipient['views']; ?></td>
							<td class="right"><?php echo $recipient['clicks']; ?></td>
							<td class="right">
								<?php if ($recipient['success'] == '1') { ?>
									<?php echo $entry_yes; ?>
								<?php } else { ?>
									<?php echo $entry_no; ?>
								<?php } ?>
							</td>
							<?php if ($this->config->get('ne_bounce')) { ?>
							<td class="right">
								<?php if ($recipient['bounced'] == '1') { ?>
									<?php echo $entry_yes; ?>
								<?php } else { ?>
									<?php echo $entry_no; ?>
								<?php } ?>
							</td>
							<?php } ?>
							<td align="right">[ <a rel="detail" href="<?php echo $detail_link . $recipient['stats_personal_id']; ?>"><?php echo $button_details; ?></a> ]</td>
						</tr>
							<?php } ?>
						<?php } else { ?>
						<tr>
							<td class="center" colspan="<?php echo $this->config->get('ne_bounce') ? '7' : '6' ?>"><?php echo $text_no_results; ?></td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
				<div class="pagination"><?php echo $pagination; ?></div>
            </td>
          </tr>
        </table>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
  $(function (){
    $('a[rel="detail"]').click(function() {
        var url = this.href;
        var dialog = $('<div style="display:none" class="ne_loading"></div>').appendTo('body');
        dialog.dialog({
        	title: '<?php echo $entry_track; ?>',
        	width: '600',
            close: function(event, ui) {
                dialog.remove();
            },
            modal: true
        });
        dialog.load(
            url, 
            {},
            function (responseText, textStatus, XMLHttpRequest) {
                dialog.removeClass('ne_loading');
            }
        );
        return false;
    });
  });

  <?php if (count($detail['timeline'])) { ?>
  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawChart);
  function drawChart() {
    var data = google.visualization.arrayToDataTable([
      ['<?php echo $text_time; ?>', '<?php echo $text_sent; ?>', '<?php echo $text_views; ?>'],
      <?php $i = 1; $max = 4; $total = count($detail['timeline']); 
      foreach ($detail['timeline'] as $date => $value) {
      	if ($max < $value['sent'])
      		$max = $value['sent'];

      	if ($max < $value['read'])
      		$max = $value['read'];
      ?>
      ['<?php echo $date; ?>', <?php echo $value['sent']; ?>, <?php echo $value['read']; ?>]<?php if ($i < $total) echo ','; echo PHP_EOL; $i++; ?>
      <?php } ?>
    ]);
    var chart = new google.visualization.AreaChart(document.getElementById('chart_div'))
    chart.draw(data, {pointSize: 10, vAxis: {format:'0', minValue: '0', maxValue: '<?php echo $max; ?>'}});
  }
  <?php } ?>
//--></script>
<script type="text/javascript"><!--
function filter() {
  url = 'index.php?route=ne/stats/detail&token=<?php echo $token; ?>&id=<?php echo $detail["stats_id"]; ?>';

  var filter_name = $('input[name=\'filter_name\']').attr('value');
  
  if (filter_name) {
    url += '&filter_name=' + encodeURIComponent(filter_name);
  }
  
  var filter_email = $('input[name=\'filter_email\']').attr('value');
  
  if (filter_email) {
    url += '&filter_email=' + encodeURIComponent(filter_email);
  }

  var filter_success = $('select[name=\'filter_success\']').attr('value');

  if (filter_success) {
    url += '&filter_success=' + encodeURIComponent(filter_success);
  }

  <?php if ($this->config->get('ne_bounce')) { ?>
  var filter_bounced = $('select[name=\'filter_bounced\']').attr('value');

  if (filter_bounced) {
    url += '&filter_bounced=' + encodeURIComponent(filter_bounced);
  }
  <?php } ?>
  
  location = url;
}
//--></script>
<?php echo $footer; ?>