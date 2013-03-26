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
			<h1><img src="view/image/ne/templates.png" alt="" width="22" height="22" /> <?php echo $heading_title; ?></h1>
			<div class="buttons"><a onclick="$('#form').attr('action', '<?php echo $copy_default; ?>'); $('#form').submit();" class="button"><span><?php echo $button_copy_default; ?></span></a> <a onclick="$('#form').attr('action', '<?php echo $copy; ?>'); $('#form').submit();" class="button"><span><?php echo $button_copy; ?></span></a> <a onclick="location = '<?php echo $insert; ?>'" class="button"><span><?php echo $button_insert; ?></span></a> <a onclick="$('#form').submit();" class="button"><span><?php echo $button_delete; ?></span></a></div>
		</div>
		<div class="content">
			<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
				<table class="list">
					<thead>
						<tr>
							<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
							<td class="left"><?php echo $column_name; ?></td>
							<td class="left"><?php echo $column_last_change; ?></td>
							<td class="right"><?php echo $column_actions; ?></td>
						</tr>
					</thead>
					<tbody>
						<?php if ($templates) { ?>
						<?php foreach ($templates as $template) { ?>
						<tr>
							<td style="text-align: center;">
								<?php if ($template['template_id'] != '1') { ?>
								<?php if ($template['selected']) { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $template['template_id']; ?>" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $template['template_id']; ?>" />
								<?php } ?>
								<?php } ?>
							</td>
							<td class="left"><?php echo $template['name']; ?></td>
							<td class="left"><?php echo $template['datetime']; ?></td>
							<td align="right">[ <a href="<?php echo $edit . $template['template_id']; ?>"><?php echo $button_edit; ?></a> ]</td>
						</tr>
						<?php } ?>
						<?php } else { ?>
						<tr>
							<td class="center" colspan="4"><?php echo $text_no_results; ?></td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>
<?php echo $footer; ?>