using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Com.VadimUnityDev.Robots_vs_Zombies_VR
{
    public abstract class PlayerGeneralScript : Photon.PunBehaviour
    {
        #region Protected Variables

        [Tooltip("Health of current player")]
        protected byte health = 100;

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
        [PunRPC]
        public virtual void SetHUD()
        {
            //Утром сделать в плеймоде топ расположение канваса, и запомнить его как префаб, (или нет) и засунуть с таким же расположением в префаб игрока(и зомби) с расположением как при старте.
            //Если не поможет, то инстансить префаб канваса с такими же параметрами всегда)0
            GameObject go = Instantiate(Resources.Load("CanvasPlayer") as GameObject, gameObject.transform.Find("Head"));
            go.transform.localPosition = new Vector3(-0.4017296f, 0.7296268f, 2.908004f);
            go.transform.position = gameObject.transform.position;
        }

        #endregion
    }
}
