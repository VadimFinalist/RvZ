using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerManager : Photon.PunBehaviour {
    public GameObject[] spawns;

    [Tooltip("Reference to the player Robot avatar prefab")]
    public GameObject playerRobotAvatar;

    [Tooltip("Reference to the player Zombie avatar prefab")]
    public GameObject playerZombieAvatar;
    
    public delegate void OnCharacterInstantiated(GameObject character);

    public static event OnCharacterInstantiated CharacterInstantiated;

    /// <summary>
    /// On script start
    /// </summary>
    void Awake() {
        if (playerRobotAvatar == null || playerZombieAvatar == null) {
            Debug.LogError("MyNetworkManager is missing a reference to the player avatar prefab!");
        }
    }

    /// <summary>
    /// When joined Room
    /// </summary>
    public override void OnJoinedRoom()
    {
        //Debug.Log("[PlayerManager] OnJoinedRoom ");

        if (PhotonNetwork.isMasterClient)
        {
            NewPlayer(0);
        }
    }

    /// <summary>
    /// When player connected
    /// </summary>
    /// <param name="newPlayer"></param>
    public override void OnPhotonPlayerConnected(PhotonPlayer newPlayer)
    {
        if (PhotonNetwork.isMasterClient)
        {
            var idx = PhotonNetwork.otherPlayers.Length;
            photonView.RPC("NewPlayer", newPlayer, idx);
        }
    }

    /// <summary>
    /// New player instantiation
    /// </summary>
    /// <param name="idx"></param>
    [PunRPC]
    void NewPlayer(int idx)
    {
        // Create a new player at the appropriate spawn spot
        var count = PhotonNetwork.room.playerCount;
        var trans = spawns[idx].transform;

        // Robots and zombies will spawn one after another
        if (count % 2 != 0)
        {
            var player = PhotonNetwork.Instantiate(playerRobotAvatar.name, trans.position, trans.rotation, 0);
        }
        else
        {
            var player = PhotonNetwork.Instantiate(playerZombieAvatar.name, trans.position, trans.rotation, 0);
        }

    }
}
