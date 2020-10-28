using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

public class HapticManager {

#if UNITY_IOS
	[DllImport("__Internal")]
	private static extern void _setupHapticGenerators();
	
	public static void SetupHapticGenerators()
	{
		if( Application.platform == RuntimePlatform.IPhonePlayer )
			_setupHapticGenerators();
	}

	[DllImport("__Internal")]
	private static extern void _prepareHapticEngine();
	
	public static void PrepareHapticEngine()
	{
		if( Application.platform == RuntimePlatform.IPhonePlayer )
			_prepareHapticEngine();
	}

	[DllImport("__Internal")]
	private static extern void _triggerImpactLight();
	
	public static void TriggerImpactLight()
	{
		if( Application.platform == RuntimePlatform.IPhonePlayer )
			_triggerImpactLight();
	}

	[DllImport("__Internal")]
	private static extern void _triggerImpactMedium();
	
	public static void TriggerImpactMedium()
	{
		if( Application.platform == RuntimePlatform.IPhonePlayer )
			_triggerImpactMedium();
	}

	[DllImport("__Internal")]
	private static extern void _triggerImpactHeavy();
	
	public static void TriggerImpactHeavy()
	{
		if( Application.platform == RuntimePlatform.IPhonePlayer )
			_triggerImpactHeavy();
	}

	[DllImport("__Internal")]
	private static extern void _triggerNotificationSuccess();
	
	public static void TriggerNotificationSuccess()
	{
		if( Application.platform == RuntimePlatform.IPhonePlayer )
			_triggerNotificationSuccess();
	}

	[DllImport("__Internal")]
	private static extern void _triggerNotificationWarning();
	
	public static void TriggerNotificationWarning()
	{
		if( Application.platform == RuntimePlatform.IPhonePlayer )
			_triggerNotificationWarning();
	}

	[DllImport("__Internal")]
	private static extern void _triggerNotificationError();
	
	public static void TriggerNotificationError()
	{
		if( Application.platform == RuntimePlatform.IPhonePlayer )
			_triggerNotificationError();
	}

	[DllImport("__Internal")]
	private static extern void _triggerSelectionChange();
	
	public static void TriggerSelectionChange()
	{
		if( Application.platform == RuntimePlatform.IPhonePlayer )
			_triggerSelectionChange();
	}

	[DllImport("__Internal")]
	private static extern void _releaseHapticGenerators();
	
	public static void ReleaseHapticGenerators()
	{
		if( Application.platform == RuntimePlatform.IPhonePlayer )
			_releaseHapticGenerators();
	}
	#endif
}
