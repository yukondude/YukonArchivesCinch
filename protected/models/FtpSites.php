<?php

/**
 * This is the model class for table "ftp_sites".
 *
 * The followings are the available columns in table 'ftp_sites':
 * @property integer $id
 * @property string $path
 * @property string $username
 * @property string $password
 * @property integer $user_id
 */
class FtpSites extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @return FtpSites the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'ftp_sites';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('path, username, password', 'required'),
			array('path', 'length', 'max'=>2084),
			array('username', 'length', 'max'=>25),
			array('password', 'length', 'max'=>50),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, path, username, port, user_id', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
            'user' => array(self::BELONGS_TO, 'User', 'user_id'),
            'file_info_settings' => array(self::HAS_ONE, 'FileInfoSettings', 'file_id')
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'path' => 'Path',
			'username' => 'Username',
			'password' => 'Password',
            'port' => 'Port',
			'user_id' => 'User',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('path',$this->path,true);
		$criteria->compare('username',$this->username,true);
		$criteria->compare('password',$this->password,true);
        $criteria->compare('port',$this->port,true);
		$criteria->compare('user_id',$this->user_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}