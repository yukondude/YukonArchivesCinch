<?php
/**
* PDF_Metadata class file
*
* Writes extracted PDF metadata to the database.
* @category PDF_Metadata
* @package PDF_Metadata
* @author State Library of North Carolina - Digital Information Management Program <digital.info@ncdcr.gov>
* @author Dean Farrell
* @version 1.4
* @license Unlicense {@link http://unlicense.org/}
*/

/**
* Writes extracted PDF metadata to the database.
* @author State Library of North Carolina - Digital Information Management Program <digital.info@ncdcr.gov>
* @author Dean Farrell
* @version 1.4
* @license Unlicense {@link http://unlicense.org/}
*/
class PDF_Metadata extends FileTypeActiveRecord {
	/**
	* Writes extracted PDF metadata to the database
	* @param array $metadata
	* @param $file_id
	* @param $user_id
	* @access public
	* @return object.  Yii DAO object
	*/
	public function writeMetadata(array $metadata, $file_id, $user_id) {
		$possible_fields = array(
			'Author' => 'author',  
			'Creation-Date' => 'creation_date', 
			'Last-Modified' => 'last_modified', 
			'creator' => 'creator',
			'producer' => 'producer',
			'resourceName' => 'resource_name', 
			'title' => 'title',
			'xmpTPg' => 'pages',
			'subject' => 'subject',
			'keywords' => 'keywords',
			'licensed_to' => 'licensed_to',
			'doc_title' => 'possible_doc_title',
			'doc_keywords' => 'possible_doc_keywords',
			'file_id' => 'file_id',
			'user_id' => 'user_id'
		);
		
		$actual_fields = $this->returnedFields($possible_fields, $metadata);
		$query_fields = $this->addIdInfo($actual_fields, array('file_id' => 'file_id', 'user_id' => 'user_id'));
		$full_metadata = $this->addIdInfo($metadata, array('file_id' => $file_id, 'user_id' => $user_id));
		$bind_params = $this->bindValuesBuilder($query_fields, $full_metadata);
		
		$sql = 'INSERT INTO PDF_Metadata(' . $this->queryBuilder($query_fields) . ') 
			VALUES(' . $this->queryBuilder($query_fields, true) . ')';
		
		$write_files = Yii::app()->db->createCommand($sql);
		$done = $write_files->execute($bind_params);
	}
}