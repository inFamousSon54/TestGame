using System.Collections;
using UnityEngine;

public class iOSHapticController : MonoBehaviour
{

	public static iOSHapticController instance = null;

	void Awake ()
	{
		instance = this;
	}

	public void SetupHapticGenerators ()
	{
#if UNITY_IOS
		HapticManager.SetupHapticGenerators ();
#endif
	}

	public void PrepareHapticEngine ()
	{
#if UNITY_IOS
		HapticManager.PrepareHapticEngine ();
#endif
	}

	public void TriggerImpactLight ()
	{
#if UNITY_IOS
		HapticManager.TriggerImpactLight ();
#endif
	}

	public void TriggerImpactMedium ()
	{
#if UNITY_IOS
		HapticManager.TriggerImpactMedium ();
#endif
	}

	public void TriggerImpactHeavy ()
	{
#if UNITY_IOS
		HapticManager.TriggerImpactHeavy ();
#endif
	}

	public void TriggerNotificationSuccess ()
	{
#if UNITY_IOS
		HapticManager.TriggerNotificationSuccess ();
#endif
	}

	public void TriggerNotificationWarning ()
	{
#if UNITY_IOS
		HapticManager.TriggerNotificationWarning ();
#endif
	}

	public void TriggerNotificationError ()
	{
#if UNITY_IOS
		HapticManager.TriggerNotificationError ();
#endif
	}

	public void TriggerSelectionChange ()
	{
#if UNITY_IOS
		HapticManager.TriggerSelectionChange ();
#endif
	}

	public void ReleaseHapticGenerators ()
	{
#if UNITY_IOS
		HapticManager.ReleaseHapticGenerators ();
#endif
	}
}