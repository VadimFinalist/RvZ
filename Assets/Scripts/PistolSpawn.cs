using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PistolSpawn : MonoBehaviour {

    private int _count = 0;
    private bool isPistolTryToSpawn = false;
    private bool isPistolSpawningNow = false;

    public GameObject pistolGun;

    // Use this for initialization
    void Start() {

    }

    // Update is called once per frame
    void Update() {
        if (!IsSpawnerEmpty())
        {
            isPistolTryToSpawn = false;
            Debug.Log("Spawner is not empty!");
        }
        else
        {
            Debug.Log("Spawner is empty!");
            if (!isPistolTryToSpawn && !isPistolSpawningNow)
                StartCoroutine(PistolRespawn(5.0f));
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        //if (other.gameObject.tag.Contains("Gun"))
        ++_count;
    }

    private void OnTriggerExit(Collider other)
    {
        //if (other.gameObject.tag.Contains("Gun"))
        --_count;
    }

    private bool IsSpawnerEmpty()
    {
        return _count == 0;
    }

    private IEnumerator PistolRespawn(float duration)
    {
        isPistolTryToSpawn = true;
        isPistolSpawningNow = true;

        Debug.Log("Pistol will spawn after " + duration.ToString() + " seconds!");

        yield return new WaitForSeconds(duration);
        Instantiate(pistolGun);
        isPistolTryToSpawn = false;
        isPistolSpawningNow = false;
    }

}
