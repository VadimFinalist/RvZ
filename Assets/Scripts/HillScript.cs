using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HillScript : MonoBehaviour {

    private int currentScore = 0;
    private int hillTeleportCounter = 1;
    private int scoreToWin = 1000;

    private float hillStandMaxValue;
    private float hillStandValue = 0.0f;

    private bool isCouroutineEnded = false;
    private bool isCouroutineStarted = false;
    private bool hillCanTeleport;
    private bool isHillCaptured;

    public GameObject[] hillsPositions;
    public GameObject hillPoint;
    public GameObject hillMessagesTextObject;
    public GameObject hillScoreTextObject;
    public GameObject sliderHillCaptureObject;

    public Slider sliderHillCaptureSlider;
    public Text hillMessagesText;
    public Text hillScoreText;

    // Use this for initialization
    void Start ()
    {
        hillCanTeleport = true;
        hillStandMaxValue = sliderHillCaptureSlider.maxValue;

        hillScoreTextObject.SetActive(false);
        hillMessagesTextObject.SetActive(false);
        sliderHillCaptureObject.SetActive(false);
        InvokeRepeating("HillTeleport", 5.0f, 5.0f);
    }

    // Update is called once per frame
    void Update()
    {
        ScoreUp();
    }

    private void ScoreUp()
    {
        if (isHillCaptured)
        {
            if (currentScore < scoreToWin)
            {
                currentScore++;
                if (currentScore % 100 == 0)
                {
                    hillScoreText.text = currentScore.ToString() + " / 1000";
                }
            }
            else if (currentScore == scoreToWin)
            {
                if (!isCouroutineStarted)
                {
                    StartCoroutine(TemporarilyActivateWin(5.0f));
                }
                if (isCouroutineEnded)
                {
                    return;
                }
            }
        }
    }

    private void HillTeleport()
    {
        if (hillCanTeleport)
        {
            if (hillTeleportCounter == hillsPositions.Length)
            {
                hillTeleportCounter = 0;
            }
            gameObject.transform.position = hillsPositions[hillTeleportCounter].transform.position;
            hillTeleportCounter++;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "VRCamera")
        {
            hillCanTeleport = false;
            if (hillStandValue != hillStandMaxValue)
            {
                sliderHillCaptureObject.SetActive(true);
            }

            Debug.Log("Hill on!");
        }
    }

    private void OnTriggerStay(Collider other)
    {
        if (other.gameObject.tag == "VRCamera")
        {
            if (hillStandValue == hillStandMaxValue)
            {
                return;
            }
            if (hillStandValue < hillStandMaxValue)
            {
                hillStandValue++;
                
                //Blinking
                //if (Time.fixedTime % .5 < .2)
                //{
                //    GetComponent<Renderer>().enabled = false;
                //}
                //else
                //{
                //    GetComponent<Renderer>().enabled = true;
                //}
            }
            sliderHillCaptureSlider.value = hillStandValue;
            if (hillStandValue == hillStandMaxValue)
            {
                gameObject.GetComponent<Renderer>().material.SetColor("_TintColor", Color.green);
                hillPoint.GetComponent<Renderer>().material.SetColor("_TintColor", Color.green);

                isHillCaptured = true;
                sliderHillCaptureObject.SetActive(false);
                hillScoreTextObject.SetActive(true);
                StartCoroutine(TemporarilyActivateCaptured(3.00f));

                Debug.Log("Captured!");
            }
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.tag == "VRCamera")
        {
            hillCanTeleport = true;
            sliderHillCaptureObject.SetActive(false);
            if (hillStandValue != hillStandMaxValue)
            {
                hillStandValue = 0.0f;
            }

            Debug.Log("Hill off!");
        }
    }

    private IEnumerator TemporarilyActivateCaptured(float duration)
    {
        hillMessagesTextObject.SetActive(true);
        hillMessagesText.text = "Hill captured!";
        yield return new WaitForSeconds(duration);
        hillMessagesTextObject.SetActive(false);
    }

    private IEnumerator TemporarilyActivateWin(float duration)
    {
        isCouroutineEnded = false;
        isCouroutineStarted = true;
        hillMessagesTextObject.SetActive(true);
        hillMessagesText.text = "You won!";
        yield return new WaitForSeconds(duration);
        hillMessagesTextObject.SetActive(false);
        hillScoreTextObject.SetActive(false);
        isCouroutineEnded = true;
    }
}
