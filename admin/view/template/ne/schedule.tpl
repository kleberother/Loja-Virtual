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
			<h1><img src="view/image/ne/schedule.png" alt="" width="22" height="22" /> <?php echo $heading_title; ?></h1>
			<div class="buttons"><a onclick="location = '<?php echo $insert; ?>'" class="button"><span><?php echo $button_insert; ?></span></a> <a onclick="$('#form').submit();" class="button"><span><?php echo $button_delete; ?></span></a></div>
		</div>
		<div class="content">
			<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
				<table class="list">
					<thead>
						<tr>
							<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
							<td class="left">
								<?php if ($sort == 'name') { ?>
								<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
								<?php } ?>
							</td>
							<td class="left">
								<?php if ($sort == 'to') { ?>
								<a href="<?php echo $sort_to; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_to; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_to; ?>"><?php echo $column_to; ?></a>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($sort == 'active') { ?>
								<a href="<?php echo $sort_active; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_active; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_active; ?>"><?php echo $column_active; ?></a>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($sort == 'recurrent') { ?>
								<a href="<?php echo $sort_recurrent; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_recurrent; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_recurrent; ?>"><?php echo $column_recurrent; ?></a>
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
							<td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
							<td>
								<select name="filter_to">
									<?php if ($filter_to == '') { ?>
						            <option value="" selected="selected"></option>
						            <?php } else { ?>
						            <option value=""></option>
						            <?php } ?>
						            <?php if ($filter_to == 'newsletter') { ?>
						            <option value="newsletter" selected="selected"><?php echo $text_newsletter; ?></option>
						            <?php } else { ?>
						            <option value="newsletter"><?php echo $text_newsletter; ?></option>
						            <?php } ?>
						            <?php if ($filter_to == 'customer_all') { ?>
						            <option value="customer_all" selected="selected"><?php echo $text_customer_all; ?></option>
						            <?php } else { ?>
						            <option value="customer_all"><?php echo $text_customer_all; ?></option>
						            <?php } ?>
						            <?php if ($filter_to == 'customer_group') { ?>
						            <option value="customer_group" selected="selected"><?php echo $text_customer_group; ?></option>
						            <?php } else { ?>
						            <option value="customer_group"><?php echo $text_customer_group; ?></option>
						            <?php } ?>
						            <?php if ($filter_to == 'customer') { ?>
						            <option value="customer" selected="selected"><?php echo $text_customer; ?></option>
						            <?php } else { ?>
						            <option value="customer"><?php echo $text_customer; ?></option>
						            <?php } ?>
						            <?php if ($filter_to == 'affiliate_all') { ?>
						            <option value="affiliate_all" selected="selected"><?php echo $text_affiliate_all; ?></option>
						            <?php } else { ?>
						            <option value="affiliate_all"><?php echo $text_affiliate_all; ?></option>
						            <?php } ?>
						            <?php if ($filter_to == 'affiliate') { ?>
						            <option value="affiliate" selected="selected"><?php echo $text_affiliate; ?></option>
						            <?php } else { ?>
						            <option value="affiliate"><?php echo $text_affiliate; ?></option>
						            <?php } ?>
						            <?php if ($filter_to == 'product') { ?>
						            <option value="product" selected="selected"><?php echo $text_product; ?></option>
						            <?php } else { ?>
						            <option value="product"><?php echo $text_product; ?></option>
						            <?php } ?>
									<?php if ($filter_to == 'marketing') { ?>
							            <option value="marketing" selected="selected"><?php echo $text_marketing; ?></option>
							        <?php } else { ?>
							        	<option value="marketing"><?php echo $text_marketing; ?></option>
							        <?php } ?>
									<?php if ($filter_to == 'marketing_all') { ?>
							            <option value="marketing_all" selected="selected"><?php echo $text_marketing_all; ?></option>
							        <?php } else { ?>
							        	<option value="marketing_all"><?php echo $text_marketing_all; ?></option>
							        <?php } ?>
									<?php if ($filter_to == 'subscriber') { ?>
							            <option value="subscriber" selected="selected"><?php echo $text_subscriber_all; ?></option>
							        <?php } else { ?>
							        	<option value="subscriber"><?php echo $text_subscriber_all; ?></option>
							        <?php } ?>
									<?php if ($filter_to == 'all') { ?>
							            <option value="all" selected="selected"><?php echo $text_all; ?></option>
							        <?php } else { ?>
							        	<option value="all"><?php echo $text_all; ?></option>
							        <?php } ?>
						          </select>
							</td>
							<td class="right">
								<select name="filter_active">
									<option value=""></option>
									<?php if ($filter_active == '1') { ?>
									<option value="1" selected="selected"><?php echo $entry_yes; ?></option>
									<?php } else { ?>
									<option value="1"><?php echo $entry_yes; ?></option>
									<?php } ?>
									<?php if ($filter_active == '0') { ?>
									<option value="0" selected="selected"><?php echo $entry_no; ?></option>
									<?php } else { ?>
									<option value="0"><?php echo $entry_no; ?></option>
									<?php } ?>
								</select>
							</td>
							<td class="right">
								<select name="filter_recurrent">
									<option value=""></option>
									<?php if ($filter_recurrent == '1') { ?>
									<option value="1" selected="selected"><?php echo $entry_yes; ?></option>
									<?php } else { ?>
									<option value="1"><?php echo $entry_yes; ?></option>
									<?php } ?>
									<?php if ($filter_recurrent == '0') { ?>
									<option value="0" selected="selected"><?php echo $entry_no; ?></option>
									<?php } else { ?>
									<option value="0"><?php echo $entry_no; ?></option>
									<?php } ?>
								</select>
							</td>
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
						<?php if ($schedule) { ?>
						<?php foreach ($schedule as $entry) { ?>
						<tr>
							<td style="text-align: center;">
								<?php if ($entry['selected']) { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $entry['schedule_id']; ?>" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $entry['schedule_id']; ?>" />
								<?php } ?>
							</td>
							<td class="left"><?php echo $entry['name']; ?></td>
							<td class="left">
					            <?php if ($entry['to'] == 'newsletter') { 
					            	echo $text_newsletter; 
					            } elseif ($entry['to'] == 'customer_all') { 
					            	echo $text_customer_all;
					            } elseif ($entry['to'] == 'customer_group') {
					            	echo $text_customer_group;
					            } elseif ($entry['to'] == 'customer') {
					            	echo $text_customer;
					            } elseif ($entry['to'] == 'affiliate_all') {
					            	echo $text_affiliate_all;
					            } elseif ($entry['to'] == 'affiliate') {
					            	echo $text_affiliate;
					            } elseif ($entry['to'] == 'product') {
					            	echo $text_product;
					            } elseif ($entry['to'] == 'marketing') {
					            	echo $text_marketing;
					            } elseif ($entry['to'] == 'marketing_all') {
									echo $text_marketing_all;
								} elseif ($entry['to'] == 'subscriber') {
									echo $text_subscriber_all;
								} elseif ($entry['to'] == 'all') {
									echo $text_all;
								} ?>
							</td>
							<td class="right">
								<?php if ($entry['active'] == '1') { ?>
									<?php echo $entry_yes; ?>
								<?php } else { ?>
									<?php echo $entry_no; ?>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($entry['recurrent'] == '1') { ?>
									<?php echo $entry_yes; ?>
								<?php } else { ?>
									<?php echo $entry_no; ?>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($entry['store_id'] == '0') { ?>
									<?php echo $text_default; ?>
								<?php } else { ?>
									<?php foreach ($stores as $store) { ?>
										<?php if ($entry['store_id'] == $store['store_id']) { ?>
											<?php echo $store['name']; ?>
											<?php break; ?>
										<?php } ?>
									<?php } ?>
								<?php } ?>
							</td>
							<td align="right"><a href="<?php echo $update . $entry['schedule_id']; ?>">[ <?php echo $text_edit; ?> ]</a></td>
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
	url = 'index.php?route=ne/schedule&token=<?php echo $token; ?>';
	
	var filter_name = $('input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}
	
	var filter_active = $('select[name=\'filter_active\']').attr('value');
	
	if (filter_active) {
		url += '&filter_active=' + encodeURIComponent(filter_active);
	}
	
	var filter_recurrent = $('select[name=\'filter_recurrent\']').attr('value');
	
	if (filter_recurrent) {
		url += '&filter_recurrent=' + encodeURIComponent(filter_recurrent);
	}

	var filter_to = $('select[name=\'filter_to\']').attr('value');
	
	if (filter_to) {
		url += '&filter_to=' + encodeURIComponent(filter_to);
	}

	var filter_store = $('select[name=\'filter_store\']').attr('value');
	
	if (filter_store) {
		url += '&filter_store=' + encodeURIComponent(filter_store);
	}
	
	location = url;
}
//--></script>
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
//--></script>
<?php echo $footer; ?>