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
			<div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_delete; ?></span></a></div>
		</div>
		<div class="content">
			<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
				<table class="list">
					<thead>
						<tr>
							<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
							<td class="left">
								<?php if ($sort == 'date') { ?>
								<a href="<?php echo $sort_date; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_date; ?>"><?php echo $column_date; ?></a>
								<?php } ?>
							</td>
							<td class="left">
								<?php if ($sort == 'subject') { ?>
								<a href="<?php echo $sort_subject; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_subject; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_subject; ?>"><?php echo $column_subject; ?></a>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($sort == 'recipients_count') { ?>
								<a href="<?php echo $sort_recipients; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_recipients; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_recipients; ?>"><?php echo $column_recipients; ?></a>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($sort == 'views_count') { ?>
								<a href="<?php echo $sort_views; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_views; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_views; ?>"><?php echo $column_views; ?></a>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($sort == 'store_id') { ?>
								<a href="<?php echo $sort_store; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_store; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_store; ?>"><?php echo $column_store; ?></a>
								<?php } ?>
							</td>
							<td class="right"><?php echo $column_actions; ?></td>
						</tr>
					</thead>
					<tbody>
						<tr class="filter">
							<td></td>
							<td><input type="text" name="filter_date" value="<?php echo $filter_date; ?>" class="date" /></td>
							<td><input type="text" name="filter_subject" value="<?php echo $filter_subject; ?>" /></td>
							<td></td>
							<td></td>
							<td class="right">
								<select name="filter_store">
									<option value=""></option>
									<?php if ($filter_store == '0') { ?>
									<option value="0" selected="selected"><?php echo $text_default; ?></option>
									<?php } else { ?>
									<option value="0"><?php echo $text_default; ?></option>
									<?php } ?>
									<?php foreach ($stores as $store) { ?>
									<?php if ($filter_store == $store['store_id']) { ?>
									<option value="<?php echo $store['store_id']; ?>" selected="selected"><?php echo $store['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
							</td>
							<td align="right"><a onclick="filter();" class="button"><span><?php echo $button_filter; ?></span></a></td>
						</tr>
						<?php if ($stats) { ?>
						<?php foreach ($stats as $stat) { ?>
						<tr>
							<td style="text-align: center;">
								<?php if ($stat['selected']) { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $stat['stats_id']; ?>" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $stat['stats_id']; ?>" />
								<?php } ?>
							</td>
							<td class="left"><?php echo $stat['datetime']; ?></td>
							<td class="left">
								<?php if ($stat['store_id'] == '0') { ?>
									<a href="<?php echo $store_url . $view_url . $stat['history_id'] ?>" target="_blank"><?php echo $stat['subject']; ?></a>
								<?php } else { ?>
									<?php foreach ($stores as $store) { ?>
										<?php if ($stat['store_id'] == $store['store_id']) { ?>
											<?php echo $store['name']; ?>
											<a href="<?php echo rtrim($store['url'], '/') . '/' . $view_url . $stat['history_id'] ?>" target="_blank"><?php echo $stat['subject']; ?></a>
											<?php break; ?>
										<?php } ?>
									<?php } ?>
								<?php } ?>
							</td>
							<td class="right"><?php echo $stat['queue']; ?></td>
							<td class="right"><?php echo $stat['views']; ?></td>
							<td class="right">
								<?php if ($stat['store_id'] == '0') { ?>
									<?php echo $text_default; ?>
								<?php } else { ?>
									<?php foreach ($stores as $store) { ?>
										<?php if ($stat['store_id'] == $store['store_id']) { ?>
											<?php echo $store['name']; ?>
											<?php break; ?>
										<?php } ?>
									<?php } ?>
								<?php } ?>
							</td>
							<td align="right">[ <a href="<?php echo $detail . $stat['stats_id'] ?>"><?php echo $button_details; ?></a> ]</td>
						</tr>
						<?php } ?>
						<?php } else { ?>
						<tr>
							<td class="center" colspan="7"><?php echo $text_no_results; ?></td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</form>
			<div class="pagination"><?php echo $pagination; ?></div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=ne/stats&token=<?php echo $token; ?>';
	
	var filter_date = $('input[name=\'filter_date\']').attr('value');
	
	if (filter_date) {
		url += '&filter_date=' + encodeURIComponent(filter_date);
	}
	
	var filter_subject = $('input[name=\'filter_subject\']').attr('value');
	
	if (filter_subject) {
		url += '&filter_subject=' + encodeURIComponent(filter_subject);
	}

	var filter_store = $('select[name=\'filter_store\']').attr('value');
	
	if (filter_store) {
		url += '&filter_store=' + encodeURIComponent(filter_store);
	}
	
	location = url;
}
//--></script>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
//--></script>
<?php echo $footer; ?>