using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerController : MonoBehaviour
{


    public Transform playerTrans;
    public GameObject sphere;
    public Transform launchPosition;
    public Transform ballPos;
    public Animator animator;
    //public Slider AngleSlider;
   // public Slider LaunchSlider;
    public float TrajecoryValue=6.8f;
    public Transform _Aimer;
    public GameObject trejectoryParent;
    public bool _isThrowing;
    private float refTreject;
    void Start ()
    {
        //InitializePlayer();
    }

    public void InitializePlayer(string animType)
    {
        trejectoryParent.SetActive(false);
        _isThrowing = true;
        animator.SetTrigger(animType);
        playerTrans.rotation = Quaternion.Euler(0, 180, 0);
        
    }

    public void VictoryPose()
    {
        trejectoryParent.SetActive(false);
        _isThrowing = true;
        animator.SetTrigger("victory");
        playerTrans.rotation = Quaternion.Euler(0, 180, 0);
    }

    public void losePos()
    {
        trejectoryParent.SetActive(false);
        _isThrowing = true;
        animator.SetTrigger("sad");
        playerTrans.rotation = Quaternion.Euler(0, 180, 0);
    }

    public void StartPlayerControll()
    {
       
        playerTrans.rotation = Quaternion.Euler(0, 0, 0);
        animator.SetTrigger("idal");
        
       Invoke("waitFun",1f);

    }

    void waitFun()
    {
        _isThrowing = false;
        trejectoryParent.SetActive(true);
    }

    public void Fire()
    {
       
        GameObject r = Instantiate(sphere, launchPosition.position, Quaternion.identity);
        Quaternion a = Quaternion.Euler(0, launchPosition.rotation.eulerAngles.y, 0);
        r.GetComponent<Rigidbody>().velocity =
            launchPosition.forward * TrajecoryValue; 
        GameManager.instance.UpdateGranedCount();
        Invoke("startAiming",4);
    }
	
	void Update () {

        if (!_isThrowing  && GD._IS_GAME_START)
        {
            Swipe();
 
        }
    }
    
    Vector2 firstPressPos;
    Vector2 secondPressPos;
    Vector2 currentSwipe;
    public float horizontalSpeed = 2.0F;
    public float verticalSpeed = 2.0F;
    private float h;
    private float v;
    private float y;
    private float x;
    public void Swipe()
    {
        if(Input.GetMouseButtonDown(0))
        {
            
            firstPressPos = new Vector2(Input.mousePosition.x,Input.mousePosition.y);
        }
        if(Input.GetMouseButton(0))
        {
            
            secondPressPos = new Vector2(Input.mousePosition.x,Input.mousePosition.y);
            
            currentSwipe = new Vector2( secondPressPos.x - firstPressPos.x, secondPressPos.y - firstPressPos.y);
            
             h = horizontalSpeed * Input.GetAxis("Mouse X");
             v = verticalSpeed * Input.GetAxis("Mouse Y");
          
           // LaunchSlider.value += v; 
            //AngleSlider.value += v; 
            

            x = currentSwipe.x *Time.deltaTime*3.5f;
            y = currentSwipe.y *Time.deltaTime;
            TrajecoryValue = Mathf.Clamp(TrajecoryValue+y,6.8f,10.5f);
          
            transform.Rotate(0,x,0);
            //transform.Rotate(0,x,0);

            //  _Aimer.localPosition = new Vector3(0, -0.5f, _Aimer.localPosition.z+y*3.7f); //(Mathf.Clamp(TrajecoryValue + y, 6.8f, 10.5f)));//-8.82f //(22.76f*0.01f*((100*TrajecoryValue)/10.5f))

              
            firstPressPos = Input.mousePosition;
            if (TrajecoryValue != refTreject)
            {
                _Aimer.localPosition = new Vector3(0, -1.35f, _Aimer.localPosition.z+y*3.5f); //(Mathf.Clamp(TrajecoryValue + y, 6.8f, 10.5f)));//-8.82f //(22.76f*0.01f*((100*TrajecoryValue)/10.5f))

                // Debug.Log("Value  "+(22.76f*0.01f*((100*TrajecoryValue)/10.5f)));
                // _Aimer.localPosition = new Vector3(0, -0.5f,((TrajecoryValue-6.8f)*6.8f)); //(Mathf.Clamp(TrajecoryValue + y, 6.8f, 10.5f)));//-8.82f //(22.76f*0.01f*((100*TrajecoryValue)/10.5f))
                refTreject = TrajecoryValue;
            }
            

        }

        if (Input.GetMouseButtonUp(0))
        {
            _isThrowing = true;
            trejectoryParent.SetActive(false);
            animator.SetTrigger("throw");

        }
        

        launchPosition.GetComponent<ThreeDTrajectory>().LaunchSpeed = TrajecoryValue; 
    }

    public void startAiming()
    {
        
        if (GD._IS_GAME_START)
        {
            
            
                _isThrowing = false;
                trejectoryParent.SetActive(true);        
            
            
        }
        
    }

}
