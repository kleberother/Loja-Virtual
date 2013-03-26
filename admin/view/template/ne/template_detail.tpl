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
<div class="box">
	<div class="heading">
		<h1><img src="view/image/ne/templates.png" alt="" width="22" height="22" /> <?php echo $heading_title; ?></h1>
		<div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a> <a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
		</div>
	</div>
	<div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="form">
				<tr>
					<td colspan="2"><b><?php echo $text_settings; ?></b></td>
				</tr>
				<tr>
					<td><?php echo $entry_name; ?></td>
					<td><input type="text" name="name" size="100" value="<?php echo $name; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_product_template; ?></td>
					<td>
						<select name="uri">
							<?php foreach ($parts as $key => $part) { ?>
							<?php if ($uri == $key) { ?>
							<option value="<?php echo $key; ?>" selected="selected"><?php echo $part; ?></option>
							<?php } else { ?>
							<option value="<?php echo $key; ?>"><?php echo $part; ?></option>
							<?php } ?>
							<?php } ?>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_image_size; ?></td>
					<td><input type="text" name="product_image_width" size="3" value="<?php echo $product_image_width; ?>" /> / <input type="text" name="product_image_height" size="3" value="<?php echo $product_image_height; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_show_prices; ?></td>
					<td>
						<?php if($product_show_prices) {
						$checked1 = ' checked="checked"';
						$checked0 = '';
						} else {
						$checked1 = '';
						$checked0 = ' checked="checked"';
						} ?>
					<label for="product_show_prices_1"><?php echo $entry_yes; ?></label>
					<input type="radio"<?php echo $checked1; ?> id="product_show_prices_1" name="product_show_prices" value="1" />
					<label for="product_show_prices_0"><?php echo $entry_no; ?></label>
					<input type="radio"<?php echo $checked0; ?> id="product_show_prices_0" name="product_show_prices" value="0" />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_description_length; ?></td>
					<td><input type="text" name="product_description_length" size="3" value="<?php echo $product_description_length; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_columns; ?></td>
					<td><input type="text" name="product_cols" size="3" value="<?php echo $product_cols; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_specials_count; ?></td>
					<td><input type="text" name="specials_count" size="3" value="<?php echo $specials_count; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_latest_count; ?></td>
					<td><input type="text" name="latest_count" size="3" value="<?php echo $latest_count; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_popular_count; ?></td>
					<td><input type="text" name="popular_count" size="3" value="<?php echo $popular_count; ?>" /></td>
				</tr>
				<tr>
					<td colspan="2"><b><?php echo $text_styles; ?></b></td>
				</tr>
				<tr> 
					<td><?php echo $entry_heading_color; ?></td> 
					<td><input class="colorpicker_f" type="text" name="heading_color" value="<?php echo $heading_color; ?>" size="7" maxlength="7" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_heading_style; ?></td>
					<td><input type="text" name="heading_style" size="100" value="<?php echo $heading_style; ?>" /></td>
				</tr>
				<tr> 
					<td><?php echo $entry_name_color; ?></td> 
					<td><input class="colorpicker_f" type="text" name="product_name_color" value="<?php echo $product_name_color; ?>" size="7" maxlength="7" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_name_style; ?></td>
					<td><input type="text" name="product_name_style" size="100" value="<?php echo $product_name_style; ?>" /></td>
				</tr>
				<tr> 
					<td><?php echo $entry_model_color; ?></td> 
					<td><input class="colorpicker_f" type="text" name="product_model_color" value="<?php echo $product_model_color; ?>" size="7" maxlength="7" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_model_style; ?></td>
					<td><input type="text" name="product_model_style" size="100" value="<?php echo $product_model_style; ?>" /></td>
				</tr>
				<tr> 
					<td><?php echo $entry_price_color; ?></td> 
					<td><input class="colorpicker_f" type="text" name="product_price_color" value="<?php echo $product_price_color; ?>" size="7" maxlength="7" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_price_style; ?></td>
					<td><input type="text" name="product_price_style" size="100" value="<?php echo $product_price_style; ?>" /></td>
				</tr>
				<tr> 
					<td><?php echo $entry_price_color_special; ?></td> 
					<td><input class="colorpicker_f" type="text" name="product_price_color_special" value="<?php echo $product_price_color_special; ?>" size="7" maxlength="7" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_price_style_special; ?></td>
					<td><input type="text" name="product_price_style_special" size="100" value="<?php echo $product_price_style_special; ?>" /></td>
				</tr>
				<tr> 
					<td><?php echo $entry_price_color_when_special; ?></td> 
					<td><input class="colorpicker_f" type="text" name="product_price_color_when_special" value="<?php echo $product_price_color_when_special; ?>" size="7" maxlength="7" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_price_style_when_special; ?></td>
					<td><input type="text" name="product_price_style_when_special" size="100" value="<?php echo $product_price_style_when_special; ?>" /></td>
				</tr>
				<tr> 
					<td><?php echo $entry_description_color; ?></td> 
					<td><input class="colorpicker_f" type="text" name="product_description_color" value="<?php echo $product_description_color; ?>" size="7" maxlength="7" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_description_style; ?></td>
					<td><input type="text" name="product_description_style" size="100" value="<?php echo $product_description_style; ?>" /></td>
				</tr>
				<tr>
					<td colspan="2"><b><?php echo $text_template; ?></b></td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="languages" class="htabs">
				            <?php foreach ($languages as $language) { ?>
				            <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
				            <?php } ?>
				        </div>
				        <?php foreach ($languages as $language) { ?>
					      <div id="language<?php echo $language['language_id']; ?>">
					        <table class="form">
					          <tr>
								<td><?php echo $entry_subject; ?></td>
								<td><input type="text" name="subject[<?php echo $language['language_id']; ?>]" size="100" value="<?php echo isset($subject[$language['language_id']]) ? $subject[$language['language_id']] : ''; ?>" /></td>
							  </tr>
					          <tr>
								<td><?php echo $entry_defined_text; ?></td>
								<td><input type="text" name="defined_text[<?php echo $language['language_id']; ?>]" size="100" value="<?php echo isset($defined_text[$language['language_id']]) ? $defined_text[$language['language_id']] : ''; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_special_text; ?></td>
								<td><input type="text" name="special_text[<?php echo $language['language_id']; ?>]" size="100" value="<?php echo isset($special_text[$language['language_id']]) ? $special_text[$language['language_id']] : ''; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_latest_text; ?></td>
								<td><input type="text" name="latest_text[<?php echo $language['language_id']; ?>]" size="100" value="<?php echo isset($latest_text[$language['language_id']]) ? $latest_text[$language['language_id']] : ''; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_popular_text; ?></td>
								<td><input type="text" name="popular_text[<?php echo $language['language_id']; ?>]" size="100" value="<?php echo isset($popular_text[$language['language_id']]) ? $popular_text[$language['language_id']] : ''; ?>" /></td>
							  </tr>
								<tr>
								<td><?php echo $entry_categories_text; ?></td>
								<td><input type="text" name="categories_text[<?php echo $language['language_id']; ?>]" size="100" value="<?php echo isset($categories_text[$language['language_id']]) ? $categories_text[$language['language_id']] : ''; ?>" /></td>
							  </tr>
					          <tr>
					            <td><?php echo $entry_template_body; ?></td>
					            <td><textarea name="body[<?php echo $language['language_id']; ?>]" id="body<?php echo $language['language_id']; ?>"><?php echo isset($body[$language['language_id']]) ? $body[$language['language_id']] : ''; ?></textarea>
					            	<p><?php echo $text_message_info; ?></p>
					            </td>
					          </tr>
					        </table>
					      </div>
					    <?php } ?>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('body<?php echo $language['language_id']; ?>', {
	height: 600,
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script>
<script type="text/javascript"><!--
	$('.colorpicker_f').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val('#' + hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});
//--></script>
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#languages a').tabs(); 
$('#vtab-option a').tabs();
//--></script>
<?php echo $footer; ?>