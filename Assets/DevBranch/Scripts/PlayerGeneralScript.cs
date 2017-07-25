using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Com.VadimUnityDev.Robots_vs_Zombies_VR
{
    public abstract class PlayerGeneralScript : Photon.PunBehaviour
    {
        #region Private Variables

        //private string _textHealth;

        #endregion

        #region Protected Variables

        [Tooltip("Health value of current player")]
        protected byte health = 100;

        /*protected byte Health
        { 
            get
            {
                return health;
            }
            set
            {
                health = value;
                _textHealth = value.ToString();
            }
        }*/

        [Tooltip("Name of current player in hierarchy")]
        protected string playerName;

        [Tooltip("Team tag of current player")]
        protected string teamTag;

        [Tooltip("Head tag of current player")]
        protected string headTag;

        #endregion
        
        #region Public Methods

        /// <summary>
        /// Method which will set tag of player, and his head (which will collide)
        /// </summary>
        /// <param name="newTag"></param>
        /// <param name="newHeadTag"></param>
        [PunRPC]
        public virtual void SetTags(string newTag, string newHeadTag)
        {
            this.tag = newTag;
            gameObject.transform.Find("Head").tag = newHeadTag;
        }

        /// <summary>
        /// Method which will set name of player object
        /// </summary>
        /// <param name="newName"></param>
        [PunRPC]
        public virtual void SetName(string newName)
        {
            this.name = newName + GameObject.FindGameObjectsWithTag(tag).Length.ToString();
        }

        /// <summary>
        /// Will invoke when player health reaches zero
        /// </summary>
        [PunRPC]
        public virtual void Death()
        {
            
        }

        /// <summary>
        /// Method which will spawn player after death
        /// </summary>
        [PunRPC]
        public virtual void Respawn()
        {

        }
        
        
        /// <summary>
        /// Sets the HUD for player
        /// </summary>
        //[PunRPC]
        public virtual void SetHUD()
        {
            GameObject go = Instantiate(Resources.Load("CanvasPlayer") as GameObject, gameObject.transform.Find("Head"));
            go.transform.localPosition = new Vector3(0.03f, 1.010859f, 2.958178f);

            gameObject.transform.Find("Head/CanvasPlayerHealth/HealthGroup/TextHealth").GetComponent<Text>().text = health.ToString();
        }

        #endregion
    }
}
