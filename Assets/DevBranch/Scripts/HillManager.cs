using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

namespace Com.VadimUnityDev.Robots_vs_Zombies_VR
{
    public class HillManager : PlayerGeneralScript
    {
        #region Private Variables

        private string headRobotTag = "RobotHead";
        private string headZombieTag = "ZombieHead";
        private string teamRobotTag = "TeamRobot";
        private string teamZombieTag = "TeamZombie";

        private int hillTeleportCounter = 1;
        private int _countInHill;

        private bool isRobotInside;
        private bool isZombieInside;

        #endregion

        #region Public Variables

        public GameObject[] hillsPositions;
        public Slider slider;

        #endregion

        #region MonoBehaviour CallBacks

        /// <summary>
        /// Use this for initialization
        /// </summary>
        void Start()
        {
            scoreLimit = (int)slider.maxValue;
            InvokeRepeating("HillTeleport", 5.0f, 5.0f);
        }

        /// <summary>
        /// Update is called once per frame
        /// </summary>
        void Update()
        {

        }

        #region Collision Methods

        /// <summary>
        /// Method which invokes when player enters an hill area
        /// </summary>
        /// <param name="other"></param>
        private void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.tag == headRobotTag)
            {
                Death();
                //PlayerEnterHill(headRobotTag);
        }
            else if (other.gameObject.tag == headZombieTag)
            {
                PlayerEnterHill(headZombieTag);
            }
        }

        /// <summary>
        /// Method which invokes when player (or both R an Z) staying inside Hill
        /// </summary>
        /// <param name="other"></param>
        private void OnTriggerStay(Collider other)
        {
            if (other.gameObject.tag == headRobotTag)
            {
                PlayerStayingHill(headRobotTag);
            }
            else if (other.gameObject.tag == headZombieTag)
            {
                PlayerStayingHill(headZombieTag);
            }
        }

        /// <summary>
        /// Method which invokes when player leaves the Hill
        /// </summary>
        /// <param name="other"></param>
        private void OnTriggerExit(Collider other)
        {
            if (other.gameObject.tag == headRobotTag)
            {
                PlayerExitHill(headRobotTag);
            }
            else if (other.gameObject.tag == headZombieTag)
            {
                PlayerExitHill(headZombieTag);
            }
        }

        #endregion

        #endregion

        #region Private Methods

        /// <summary>
        /// Method which invokes when enters hill in depend on player team
        /// </summary>
        /// <param name="headTag"></param>
        private void PlayerEnterHill(string headTag)
        {
            if (headTag == headRobotTag)
            {
                _countInHill++;
                isRobotInside = true;
                InvokeRepeating("RobotsCapture", 0.0f, 0.01f);
                capturingBegan = true;
            }
            else if (headTag == headZombieTag)
            {
                _countInHill++;
                isZombieInside = true;
                InvokeRepeating("ZombiesCapture", 0.0f, 0.01f);
                capturingBegan = true;
            }

        }

        /// <summary>
        /// Method which invokes while staying hill in depend on player team
        /// </summary>
        /// <param name="headTag"></param>
        private void PlayerStayingHill(string headTag)
        {
            if (headTag == headRobotTag)
            {
                isRobotInside = true;
            }
            else if (headTag == headZombieTag)
            {
                isZombieInside = true;
            }

            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            if (isRobotInside && isZombieInside)
            {
                capturingBegan = false;

                for (int i = 0; i < GOs.Length; i++)
                {
                    GOs[i].transform.Find("Message").GetComponent<Text>().text = "Duel!";
                }

                CancelInvoke("RobotsCapture");
                CancelInvoke("ZombiesCapture");
            }
            else if (isRobotInside && !isZombieInside && !capturingBegan)
            {
                Debug.Log("Orki");
                if (!capturingBegan || sliderZombiesVal == scoreLimit)
                {
                    InvokeRepeating("RobotsCapture", 0.0f, 0.01f);
                    capturingBegan = true;
                    Debug.Log("TOKYO");
                }

                for (int i = 0; i < GOs.Length; i++)
                {
                    GOs[i].transform.Find("Message").GetComponent<Text>().text = message;
                }
            }
            else if (!isRobotInside && isZombieInside && !capturingBegan)
            {
                Debug.Log("Elfi");
                if (!capturingBegan || sliderRobotsVal == scoreLimit)
                {
                    InvokeRepeating("ZombiesCapture", 0.0f, 0.01f);
                    capturingBegan = true;
                    Debug.Log("GHOUL");
                }

                for (int i = 0; i < GOs.Length; i++)
                {
                    GOs[i].transform.Find("Message").GetComponent<Text>().text = message;
                }
            }
        }

        /// <summary>
        /// Method which invokes when exited hill in depend on player team
        /// </summary>
        /// <param name="headTag"></param>
        private void PlayerExitHill(string headTag)
        {
            if (headTag == headRobotTag)
            {
                isRobotInside = false;
                _countInHill--;

                /*if (isRobotInside && !isZombieInside)
                {
                    if (!capturingBegan)
                    {
                        InvokeRepeating("RobotsCapture", 0.0f, 0.01f);
                        capturingBegan = true;
                    }
                }*/

                if (_countInHill == 0)
                {
                    CancelInvoke("RobotsCapture");
                    capturingBegan = false;
                }
            }
            else if (headTag == headZombieTag)
            {
                isZombieInside = false;
                _countInHill--;

                /*if (!isRobotInside && isZombieInside)
                {
                    if (!capturingBegan)
                    {
                        InvokeRepeating("ZombiesCapture", 0.0f, 0.01f);
                        capturingBegan = true;
                    }
                }*/

                if (_countInHill == 0)
                {
                    CancelInvoke("ZombiesCapture");
                    capturingBegan = false;
                }
            }
        }

        /// <summary>
        /// Method which changes Hill position (only if hill is empty)
        /// </summary>
        private void HillTeleport()
        {
            if (_countInHill == -1) //Temporary, should be zero
            {
                if (hillTeleportCounter == hillsPositions.Length)
                {
                    hillTeleportCounter = 0;
                }

                gameObject.transform.position = hillsPositions[hillTeleportCounter].transform.position;
                hillTeleportCounter++;
            }
        }

        #endregion
    }
}