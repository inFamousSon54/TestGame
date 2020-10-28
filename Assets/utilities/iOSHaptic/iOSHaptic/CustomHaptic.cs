using System.Collections;
using UnityEngine;

public class CustomHaptic : MonoBehaviour
{
	public static CustomHaptic instance;
	public GameObject OffLine;
	public UnityEngine.UI.Toggle hapticToggle;

	public static bool isHaptic = true;
	public void Awake ()
	{
		instance = this;
		Read_Haptic_Data ();
		Set_UI_Items ();
	}

	void Start ()
	{
		Trigger_Light ();
	}
	public void HapticButton_Click ()
	{
		// isHaptic = !isHaptic;
		isHaptic = !hapticToggle.isOn;
		Write_Haptic_Data ();

		// Debug.Log ("Haptic Disabled" + isHaptic);
		if (OffLine != null)
			OffLine.SetActive (!isHaptic);
	}

	public void Trigger_Success ()
	{
		if (!isHaptic)
			return;
		iOSHapticController.instance.TriggerNotificationSuccess ();
	}
	public void Trigger_SelectionChange ()
	{
		if (!isHaptic)
			return;
		iOSHapticController.instance.TriggerSelectionChange ();
	}
	public void Trigger_Error ()
	{
		if (!isHaptic)
			return;
		iOSHapticController.instance.TriggerNotificationError ();
	}

	public void Trigger_Light ()
	{
		if (!isHaptic)
			return;
		iOSHapticController.instance.TriggerImpactLight ();
	}

	public void Trigger_Medium ()
	{
		if (!isHaptic)
			return;
		iOSHapticController.instance.TriggerImpactMedium ();
	}
	public void Trigger_Heavy ()
	{
		if (!isHaptic)
			return;
		iOSHapticController.instance.TriggerImpactHeavy ();
	}
	void Set_UI_Items ()
	{
		if (hapticToggle != null)
			hapticToggle.isOn = !isHaptic;

		HapticButton_Click ();
	}
	void Read_Haptic_Data ()
	{
		isHaptic = ((PlayerPrefs.GetInt ("isHaptic", 1)) == 1) ? true : false;
	}
	void Write_Haptic_Data ()
	{
		PlayerPrefs.SetInt ("isHaptic", isHaptic ? 1 : 0);
	}
}